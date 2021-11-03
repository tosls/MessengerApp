//
//  LoadUserProfile.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.10.2021.
//

import Foundation

class LoadUserProfile {
    
    static func loadUserProfile() -> UserProfileModel {
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
            let user = try JSONDecoder()
                .decode(UserProfileModel.self, from: data)
            return user
        } catch {
            print(error)
        }
        return UserProfileModel(userName: "User Name", userInfo: "About User")
    }
}
