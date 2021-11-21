//
//  ImageResponseModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import Foundation

struct ImageResponseModel: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let id: Int
    let pageURL: String
    let webformatURL: String
}
