//
//  GSDLoader.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.10.2021.
//

import UIKit

class GCDManager {
        
    func saveUserTheme(themeName: Theme) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            ThemeManager.saveUserTheme(userTheme: themeName)
        }
    }
    
    func loadUserImage(completion: @escaping (UIImage?) -> Void){
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            UserProfileImageManager.loadUserImage { image in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func saveUserImage(userImage: UIImage, completion: @escaping (Result<Bool,Error>) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            UserProfileImageManager.saveUserImage(userImage: userImage) { result in
                DispatchQueue.main.async {completion(result)}
            }
        }
    }
}

extension GCDManager: UserProfileManagerProtocol {
    
    func saveUserProfile(userData: UserProfileModel, completion: @escaping (Result<Bool,Error>) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let userManager: UserProfileManagerProtocol = GCDManager()
            userManager.saveUserProfileSettings(userData: userData) { result in
                DispatchQueue.main.async { completion(result) }
            }
        }
    }
    
    func getUserProfile(completion: @escaping (UserProfileModel) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let userManager: UserProfileManagerProtocol = GCDManager()
            userManager.loadUserProfile { userProfile in
                DispatchQueue.main.async {
                    completion(userProfile)
                }
            }
        }
    }
}


