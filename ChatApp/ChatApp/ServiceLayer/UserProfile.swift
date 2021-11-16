//
//  userProfile.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 26.09.2021.
//

import UIKit

class UserProfile {
    
    static let shared = UserProfile()
    
    private init() {}
    
    func getUserProfile() -> UserProfileModel {
        let gcdManager = GCDManager()
        var userProfile: UserProfileModel?
        gcdManager.loadUserProfile { UserProfileModel in
            userProfile = UserProfileModel
        }
        return userProfile ?? UserProfileModel(userName: "User Name", userInfo: "User Info")
    }
}
