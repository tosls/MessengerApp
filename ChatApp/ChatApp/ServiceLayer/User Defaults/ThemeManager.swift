//
//  UserSettings.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 12.10.2021.
//

import Foundation

class ThemeManager {
    
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
 }
