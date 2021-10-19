//
//  SaveUserProfile.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.10.2021.
//

import Foundation

class SaveUserProfile {
    
    static func saveUserProfileSettings(userData: UserProfileModel, completion: @escaping (Result<Bool, Error>) -> Void ) {
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
