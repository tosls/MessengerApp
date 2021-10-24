//
//  SaveUserProfileImage.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.10.2021.
//

import UIKit

class UserProfileImageManager {
    
    static let userProfileImageName = "userProfileImage"
    
    static func saveUserImage(userImage: UIImage, completion: @escaping (Bool) -> Void) {
        
        do {
            let fileName = userProfileImageName
            let filePath = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
            guard let data = userImage.jpegData(compressionQuality: 1) else {return}
            if FileManager.default.fileExists(atPath: filePath.path) {
                do {
                    try FileManager.default.removeItem(atPath: filePath.path)
                    print("Removed old image")
                } catch {
                    print("Remove error")
                }
            }
            do {
                try data.write(to: filePath)
                completion(true)
            } catch  {
                completion(false)
                print(error)
            }
        } catch {
            completion(false)
            print(error)
        }
    }
    
    static func loadUserImage(comoletion: @escaping (UIImage?) -> Void) {

        let documentDirectory = FileManager.SearchPathDirectory.applicationSupportDirectory
        
        let filePath = NSSearchPathForDirectoriesInDomains(documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let path = filePath.first {
            let userImageUrl = URL(fileURLWithPath: path).appendingPathComponent(userProfileImageName)
            let userImage = UIImage(contentsOfFile: userImageUrl.path)
            comoletion(userImage)
        }
    }
}

