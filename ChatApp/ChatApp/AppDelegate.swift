//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.09.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var showLog = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() 
//        guard let theme = SaveUserTheme.loadUserTheme() else {return true} for GCD method
//        FirebaseApp.configure() 
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
      
        // Override point for customization after application launch.
//        if showLog {
//            print("Application launch: \(#function)")
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if showLog {
            print("Application moved from an INACTIVE to an ACTIVE: \(#function)")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if showLog {
            print("Application moved from an ACTIVE to an INACTIVE: \(#function)")
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if showLog {
            print("Application moved from the BACKGROUND to the FOREGROUND: \(#function)")
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if showLog {
            print("Application moved from the FOREGROUND to the BACKGROUND: \(#function)")
        }
    }
}
