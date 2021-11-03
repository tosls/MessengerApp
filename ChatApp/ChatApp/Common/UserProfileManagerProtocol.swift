//
//  UserProfileManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.10.2021.
//

import UIKit

protocol UserProfileManagerProtocol {
}

extension UserProfileManagerProtocol {
    
    func loadUserProfile(completion: @escaping (UserProfileModel) -> Void) {
        do {
            let filePath = try FileManager.default
                .url(
                    for: .applicationSupportDirectory,
                       in: .userDomainMask,
                       appropriateFor: nil,
                       create: false
                )
                .appendingPathComponent("ProfileSettings.json")
            let data = try Data(contentsOf: filePath)
            let profileData = try JSONDecoder()
                .decode(UserProfileModel.self, from: data)
            completion(profileData)
        } catch {
            print(error)
        }
    }
    
    func saveUserProfileSettings(userData: UserProfileModel, completion: @escaping (Bool) -> Void ) {
        do {
            let filePath = try FileManager.default
                .url(
                    for: .applicationSupportDirectory,
                       in: .userDomainMask,
                       appropriateFor: nil,
                       create: true
                )
                .appendingPathComponent("ProfileSettings.json")
            try JSONEncoder()
                .encode(userData)
                .write(to: filePath)
            sleep(2)
            completion(true)
        } catch {
            completion(false)
            print(error)
        }
    }
}
