//
//  ChannelServiceProtocol.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 16.11.2021.
//

import Foundation
import CoreData

protocol ChannelCoreDataProtocol {
    
    func saveChannelsWithCoreData(channel: ChannelModel)
    func deleteChannel(object: NSManagedObject)
}
