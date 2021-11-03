//
//  ChannelModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 24.10.2021.
//

import Foundation

struct ChannelModel {
    
    let identifier: String
    let name: String
    let lastMessage: String?
    let lastActivity: Date?
}

extension ChannelModel {
    
    var toDict: [String: Any] {
        return ["name": name]
    }
}
