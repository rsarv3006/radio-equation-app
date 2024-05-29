import StoreKit
import UIKit

class SettingsScreen: UIViewController {
    var viewModel: SettingsViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.screenTitle
            appVersionLabel.text = viewModel.appVersion
        }
    }

    private lazy var contactSupportButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Contact Support", for: .normal)
        button.addTarget(self, action: #selector(onContactSupportTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()

    private lazy var openRequestNewEquationsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Request New Equations", for: .normal)
        button.addTarget(self, action: #selector(onRequestNewEquationsButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()

    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Theme.textColor
        return label
    }()

    private lazy var legalButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Legal", for: .normal)
        button.addTarget(self, action: #selector(onLegalButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()

    private lazy var purchaseAdvancedEquationsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Purchase Advanced Equations", for: .normal)
        button.addTarget(self, action: #selector(onPurchaseAdvancedEquationsButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()

    private lazy var purchaseAlternatingCurrentEquationsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Purchase Alternating Current Equations", for: .normal)
        button.addTarget(self, action: #selector(onPurchaseAlternatingCurrentEquationsButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()

    private lazy var restorePurchasesButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Restore Purchases", for: .normal)
        button.addTarget(self, action: #selector(onRestorePurchasesButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()

    private lazy var shinerButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        let paws = UIImage(systemName: "pawprint.circle")
        paws?.withTintColor(.Theme.altColor)
        button.setImage(paws, for: .normal)
        button.addTarget(self, action: #selector(onShinerButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Theme.backgroundColor
        navigationController?.navigationBar.tintColor = .Theme.altColor
        configureView()
    }

    private func configureView() {
        view.addSubview(openRequestNewEquationsButton)
        openRequestNewEquationsButton.centerX(inView: view)
        openRequestNewEquationsButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)

        view.addSubview(contactSupportButton)
        contactSupportButton.centerX(inView: view)
        contactSupportButton.anchor(top: openRequestNewEquationsButton.bottomAnchor)

        view.addSubview(appVersionLabel)
        appVersionLabel.centerX(inView: view)
        appVersionLabel.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)

        view.addSubview(legalButton)
        legalButton.centerX(inView: view)
        legalButton.anchor(top: contactSupportButton.bottomAnchor, paddingBottom: 20)

        view.addSubview(purchaseAdvancedEquationsButton)
        purchaseAdvancedEquationsButton.centerX(inView: view)
        purchaseAdvancedEquationsButton.anchor(top: legalButton.bottomAnchor, paddingBottom: 20)

        view.addSubview(purchaseAlternatingCurrentEquationsButton)
        purchaseAlternatingCurrentEquationsButton.centerX(inView: view)
        purchaseAlternatingCurrentEquationsButton.anchor(top: purchaseAdvancedEquationsButton.bottomAnchor, paddingBottom: 20)

        view.addSubview(restorePurchasesButton)
        restorePurchasesButton.centerX(inView: view)
        restorePurchasesButton.anchor(top: purchaseAlternatingCurrentEquationsButton.bottomAnchor, paddingBottom: 20)

        view.addSubview(shinerButton)
        shinerButton.centerX(inView: view)
        shinerButton.anchor(top: restorePurchasesButton.bottomAnchor, paddingBottom: 20)
    }

    @objc func onContactSupportTapped() {
        let urlString = "mailto:\(supportEmail)?subject=Support Request"

        guard let urlStringPercentEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStringPercentEncoded) else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    @objc func onRequestNewEquationsButtonTapped() {
        let urlString = "https://forms.gle/hkfRLgizENk1Gji49"

        guard let urlStringPercentEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStringPercentEncoded) else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    @objc func onPurchaseAdvancedEquationsButtonTapped() {
        Task {
            await store.requestProducts()

            guard let product = store.unlockAdvancedEquationsPurchase else {
                print("product is nil")
                return
            }

            let _ = try? await store.purchase(product)
        }
    }

    @objc func onPurchaseAlternatingCurrentEquationsButtonTapped() {
        Task {
            await store.requestProducts()

            guard let product = store.unlockAlternatingCurrentEquations else {
                print("product is nil")
                return
            }

            let _ = try? await store.purchase(product)
        }
    }

    @objc func onLegalButtonTapped() {
        let screen = LegalScreen()
        let vm = LegalScreenVM()
        screen.viewModel = vm

        navigationController?.pushViewController(screen, animated: true)
    }

    @objc func onRestorePurchasesButtonTapped() {
        Task {
            try? await AppStore.sync()
        }
    }

    @objc func onShinerButtonTapped() {
        if let link = URL(string: "https://shiner.rjs-app-dev.us/") {
            UIApplication.shared.open(link)
        }
    }
}
