//
//  MessageServiceProtocol.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 16.11.2021.
//

import Foundation

protocol MessageCoreDataProtocol {
    
    func saveMessagesWithCoreData(message: Message, identifier: String)
}
