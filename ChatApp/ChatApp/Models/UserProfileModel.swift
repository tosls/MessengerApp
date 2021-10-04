//
//  UserProfileModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 04.10.2021.
//

import UIKit


struct UserProfileModel {
    
    var userName: String?
    var userInfo: String?
    
    static func userNameToInitials(name: String) -> String {
        
        let words = name.components(separatedBy: .whitespacesAndNewlines)
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
    
    static func userInitialsToImage(_ text: String, _ imageViewHeight: CGFloat, _ imageViewWidth: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContext(CGSize(width: imageViewWidth, height: imageViewHeight))
        
        let font = UIFont(name: "Helvetica", size: imageViewHeight / 2)
        let fontStyle = NSMutableParagraphStyle()
        fontStyle.alignment = NSTextAlignment.center
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.black,
                          NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: fontStyle]
        
        let textSize = text.size(withAttributes: attributes as [NSAttributedString.Key : Any])
        
        let rectangle = CGRect(x: imageViewWidth / 2 - textSize.width / 2,
                               y: imageViewHeight / 2 - textSize.height / 2 ,
                               width: textSize.width,
                               height: textSize.height)
        
        text.draw(in:rectangle, withAttributes: attributes as [NSAttributedString.Key : Any])
        
        let userInitialsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return userInitialsImage
    }
}


