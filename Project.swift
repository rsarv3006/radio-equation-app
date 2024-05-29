import ProjectDescription

let deploymentTargetString = "16.4"

extension SettingsDictionary {
    func setProjectVersions() -> SettingsDictionary {
        let currentProjectversion = "1.3.1"
        let markettingVersion = "1"
        return appleGenericVersioningSystem().merging([
            // "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
            "CURRENT_PROJECT_VERSION": SettingValue(stringLiteral: currentProjectversion),
            "MARKETING_VERSION": SettingValue(stringLiteral: markettingVersion),

        ])
    }
}

enum ProjectTargets {
    static let RadioEquationsApp = "RadioEquationsApp"
    static let RadioEquationsAppTests = "RadioEquationsAppTests"
    static let RadioEquationsData = "RadioEquationsData"
    static let RadioEquationsDataTests = "RadioEquationsDataTests"
}

let project = Project(
    name: "RadioEquationsApp",
    settings: Settings.settings(
        base: SettingsDictionary().setProjectVersions(),
        configurations: [
            Configuration.debug(
                name: "Debug",
                settings: SettingsDictionary().automaticCodeSigning(devTeam: "4QGR522B9M")
            ),
            Configuration.release(
                name: "Release",
                settings: SettingsDictionary().automaticCodeSigning(devTeam: "4QGR522B9M")
            ),
        ], defaultSettings: .recommended()
    ),
    targets: [
        .target(
            name: ProjectTargets.RadioEquationsApp,
            destinations: .iOS,
            product: .app,
            bundleId: "rjs.app.dev.RadioEquationsApp",
            deploymentTargets: DeploymentTargets.iOS(deploymentTargetString),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UIMainStoryboardFile": "Main",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                                    "UISceneStoryboardFile": "Main"
                                ],
                            ],
                        ],
                    ],
                ]
            ),
            sources: ["RadioEquationsApp/Sources/**"],
            resources: ["RadioEquationsApp/Resources/**"],
            dependencies: [.target(name: ProjectTargets.RadioEquationsData),
                           .external(name: "JGProgressHUD"),
                           .external(name: "RichTextView")]
        ),
        .target(
            name: ProjectTargets.RadioEquationsAppTests,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "rjs.app.dev.RadioEquationsAppTests",
            deploymentTargets: DeploymentTargets.iOS(deploymentTargetString),
            infoPlist: .default,
            sources: ["RadioEquationsApp/Tests/**"],
            resources: [],
            dependencies: [.target(name: ProjectTargets.RadioEquationsApp)]
        ),
        .target(
            name: ProjectTargets.RadioEquationsData,
            destinations: .iOS,
            product: .framework,
            bundleId: "rjs.app.dev.RadioEquationsData",
            deploymentTargets: DeploymentTargets.iOS(deploymentTargetString),
            sources: ["RadioEquationsData/Sources/**"]
        ),
        .target(
            name: ProjectTargets.RadioEquationsDataTests,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "rjs.app.dev.RadioEquationsDataTests",
            deploymentTargets: DeploymentTargets.iOS(deploymentTargetString),
            sources: ["RadioEquationsData/Tests/**"]
        ),
    ]
)
