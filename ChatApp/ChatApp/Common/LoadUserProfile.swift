//
//  LoadUserProfile.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.10.2021.
//

import Foundation

class LoadUserProfile {
    
    static func loadUserProfile() -> UserProfileModel {
        var user: UserProfileModel?
        do {
            let filePath = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("ProfileSettings.json")
            let data = try Data(contentsOf: filePath)
            let profileData = try JSONDecoder().decode(UserProfileModel.self, from: data)
            user = profileData
        } catch {
            print(error)
        }
        return user ?? UserProfileModel(userName: "User Name", userInfo: "About User")
    }
}

