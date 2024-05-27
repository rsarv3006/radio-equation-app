import Foundation
import StoreKit

let unlockAdvancedFunctions = "unlockAdvancedFunctions"
let acUnlockFunctions = "re.unlock.ac.equations"

public enum StoreError: Error {
    case failedVerification
}

class Store: ObservableObject {
    var updateListenerTask: Task<Void, Error>? = nil

    @Published var unlockAdvancedEquationsPurchase: Product? = nil
    @Published var hasPurchasedUnlockAdvancedEquations: Bool = false

    @Published var unlockAlternatingCurrentEquations: Product? = nil
    @Published var hasPurchasedUnlockAlternatingCurrentEquations: Bool = false

    init() {
        updateListenerTask = listenForTransactions()
        Task {
            await requestProducts()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: [unlockAdvancedFunctions, acUnlockFunctions])
            for storeProduct in storeProducts {
                if storeProduct.type == .nonConsumable, storeProduct.id == unlockAdvancedFunctions {
                    unlockAdvancedEquationsPurchase = storeProduct
                } else if storeProduct.type == .nonConsumable, storeProduct.id == acUnlockFunctions {
                    unlockAlternatingCurrentEquations = storeProduct
                }
            }
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }

    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case let .verified(safe):
            return safe
        }
    }

    @MainActor
    func updateCustomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)

                if transaction.productType == .nonConsumable, transaction.productID == unlockAdvancedFunctions {
                    hasPurchasedUnlockAdvancedEquations = true
                } else if transaction.productType == .nonConsumable, transaction.productID == acUnlockFunctions {
                    hasPurchasedUnlockAlternatingCurrentEquations = true
                } else {
                    print("Unknown product type or id")
                }
            } catch {
                print("Failed to verify transactions")
            }
        }
    }

    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)

                    await self.updateCustomerProductStatus()

                    await transaction.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }

    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()

        switch result {
        case let .success(verification):
            let transaction = try checkVerified(verification)

            await updateCustomerProductStatus()

            await transaction.finish()
            return transaction
        case .userCancelled, .pending:
            print("Purchase cancelled")
            return nil
        default:
            print("Purchase failed")
            return nil
        }
    }
}

let store = Store()
