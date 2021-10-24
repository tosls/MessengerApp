//
//  userProfile.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 26.09.2021.
//

import UIKit

class UserProfile {
    
    static let shared = UserProfile()
    private var user: UserProfileModel?
    
    private init() {}
    
    func getUserProfile() -> UserProfileModel {
        return LoadUserProfile.loadUserProfile()
    }
}
