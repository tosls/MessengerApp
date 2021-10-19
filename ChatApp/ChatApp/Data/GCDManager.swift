//
//  GSDLoader.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.10.2021.
//

import UIKit

class GCDManager {
    
    func saveUserProfile(userData: UserProfileModel, completion: @escaping (Result<Bool,Error>) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            SaveUserProfile.saveUserProfileSettings(userData: userData) { result in
                DispatchQueue.main.async { completion(result) }
            }
        }
    }
    
    func saveUserTheme(themeName: Theme) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            ThemeManager.saveUserTheme(userTheme: themeName)
        }
    }
}


