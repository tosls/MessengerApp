//
//  UserSettings.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 12.10.2021.
//

import Foundation

final class ThemeManager {
    
    private enum SettingsKey: String {
        case themeName
    }
  
    // MARK: Save with userDefaults
    
    static var userTheme: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKey.themeName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            
            if let userTheme = newValue {
                defaults.set(userTheme, forKey: SettingsKey.themeName.rawValue)
            } else {
                defaults.removeObject(forKey: SettingsKey.themeName.rawValue)
            }
        }
    }
    
    // MARK: Save and Load json for GCD
    
    static func saveUserTheme(userTheme: Theme) {
        do {
            let filePath = try FileManager.default
                .url(
                    for: .applicationSupportDirectory,
                       in: .userDomainMask,
                       appropriateFor: nil,
                       create: true
                )
                .appendingPathComponent("ThemeSettings.json")
            try JSONEncoder()
                .encode(userTheme)
                .write(to: filePath)
        } catch {
            print("Fail saved a user theme")
        }
    }
    
    static func loadUserTheme() -> String {
        var userThemeName: String?
        do {
            let filePath = try FileManager.default
                .url(
                    for: .applicationSupportDirectory,
                       in: .userDomainMask,
                       appropriateFor: nil,
                       create: false
                )
                .appendingPathComponent("ThemeSettings.json")
            let data = try Data(contentsOf: filePath)
            let themeData = try JSONDecoder()
                .decode(Theme.self, from: data)
            userThemeName = themeData.themeName
        } catch {
            print(error)
        }
        return userThemeName ?? lightTheme.themeName
    }
 }
