//
//  GSDLoader.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.10.2021.
//

import UIKit

class GSDManager {
    
    
   
    
    
    
    func saveProfileSettings(userData: UserProfileModel, completion: @escaping (Result<Bool,Error>) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            
            do {
                let filePath = try FileManager.default
                    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent("ProfileSettings.json")
                try JSONEncoder().encode(userData)
                    .write(to: filePath)
                sleep(2)
                completion(.success(true))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
    }
    
    func loadProfileSettings() -> UserProfileModel {
        
        var userData: UserProfileModel = UserProfileModel(userName: "", userInfo: "")
            
            do {
                let filePath = try FileManager.default
                    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent("ProfileSettings.json")
                let data = try Data(contentsOf: filePath)
                let profileData = try JSONDecoder().decode(UserProfileModel.self, from: data)
                userData = profileData
            } catch {
                print(error)
        }
        
        return userData
    }
}

