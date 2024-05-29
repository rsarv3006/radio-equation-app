// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
            "JGProgressHUD": .framework,
            "RichTextView": .framework,
        ]
    )
#endif

let package = Package(
    name: "RadioEquationsApp",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/JonasGessner/JGProgressHUD", from: "2.2.0"),
        .package(url: "https://github.com/rsarv3006/RichTextView", from: "3.3.2"),
    ]
)
