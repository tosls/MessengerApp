//
//  GSDLoader.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.10.2021.
//

import UIKit

class GCDManager {
    
    let userProfileImageName = "userProfileImage"
}

extension GCDManager: UserProfileManagerProtocol {
    
    func saveUserProfile(userData: UserProfileModel, completion: @escaping (Bool) -> Void) {
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

extension GCDManager: UserProfileImageManagerProtocol {
    
    func loadUserImage(completion: @escaping (UIImage?) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let imageManager: UserProfileImageManagerProtocol = GCDManager()
            imageManager.loadUserImage(userProfileImageName: self.userProfileImageName) { image in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func saveUserImage(userImage: UIImage, completion: @escaping (Bool) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let imageManager: UserProfileImageManagerProtocol = GCDManager()
            imageManager.saveUserImage(userImage: userImage, userProfileImageName: self.userProfileImageName) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
