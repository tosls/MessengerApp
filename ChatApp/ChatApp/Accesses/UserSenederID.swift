//
//  UserSanederID.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 25.10.2021.
//

import UIKit

class UserSenderID {
    
    static let shared = UserSenderID()
    
    private init() {}
    
    func getUserSenderId() -> String {
        let userSenderID = UIDevice.current.identifierForVendor!.uuidString
        return userSenderID
    }
}
