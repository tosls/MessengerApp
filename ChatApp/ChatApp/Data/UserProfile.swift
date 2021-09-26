//
//  userProfile.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 26.09.2021.
//

import UIKit

struct UserProfile {
    
    let userName: String = "Marina Dudarenko"
    let userInfo: String = "UX/UI designer, web-designer Moscow, Russia"
    
    var userInitials: String {
        let words = userName.components(separatedBy: .whitespacesAndNewlines)
        let letters = CharacterSet.letters
        var firstInital = ""
        var secondInitial = ""
        var firstInitalFound = false
        var secondInitialFound = false
        
        for (_, item) in words.enumerated() {
            for (_, char) in item.unicodeScalars.enumerated() {
                if letters .contains(char) {
                    if firstInitalFound != true {
                        firstInital = String(char)
                        firstInitalFound = true
                    } else if secondInitialFound != true {
                        secondInitial = String(char)
                        secondInitialFound = true
                    }
                    break
                } else {
                    break
                }
            }
            if firstInital.isEmpty && secondInitial.isEmpty {
                firstInital = "U"
                secondInitial = "P"
            }
        }
        return firstInital + secondInitial
    }
}
