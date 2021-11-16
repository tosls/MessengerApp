//
//  UserProfileImageManagerProtocol.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 16.11.2021.
//

import UIKit

protocol UserProfileImageManagerProtocol {
}

extension UserProfileImageManagerProtocol {
    
    func saveUserImage(userImage: UIImage, userProfileImageName: String, completion: @escaping (Bool) -> Void) {
        do {
            let fileName = userProfileImageName
            let filePath = try FileManager.default
                .url(
                    for: .applicationSupportDirectory,
                       in: .userDomainMask,
                       appropriateFor: nil,
                       create: true
                )
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
            } catch {
                completion(false)
                print(error)
            }
        } catch {
            completion(false)
            print(error)
        }
    }
    
    func loadUserImage(userProfileImageName: String, comoletion: @escaping (UIImage?) -> Void) {
        let documentDirectory = FileManager.SearchPathDirectory.applicationSupportDirectory
        
        let filePath = NSSearchPathForDirectoriesInDomains(documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        guard let path = filePath.first else {return}
        let userImageUrl = URL(fileURLWithPath: path).appendingPathComponent(userProfileImageName)
        let userImage = UIImage(contentsOfFile: userImageUrl.path)
        comoletion(userImage)
    }
}
