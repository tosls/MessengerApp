//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.09.2021.
//

import UIKit
import Firebase
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        guard let theme = ThemeManager.userTheme else {return true}
        switch theme {
        case "DarkTheme":
            ThemeSettings.themeChanging(selectedTheme: darkTheme)
        case "LightTheme":
            ThemeSettings.themeChanging(selectedTheme: lightTheme)
        case "CustomTheme":
            ThemeSettings.themeChanging(selectedTheme: customTheme)
        default:
            return true
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
