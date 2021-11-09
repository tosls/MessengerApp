//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.11.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores { (persistent, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(persistent.url ?? "")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    lazy var contex = persistentContainer.viewContext
    lazy var backgroundContex = persistentContainer.newBackgroundContext()
    
    // MARK: CoreData for channels
    
    func saveChannelsWithCoreData(channel: ChannelModel) {
        
        backgroundContex.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        backgroundContex.shouldDeleteInaccessibleFaults = true
        backgroundContex.automaticallyMergesChangesFromParent = true
        
        guard let channelObject = NSEntityDescription.entity(forEntityName: "DBChannel", in: contex) else {return}
        let channelData = DBChannel(entity: channelObject, insertInto: contex)
        
        channelData.name = channel.name
        channelData.lastMessage = channel.lastMessage
        channelData.lastActivity = channel.lastActivity
        channelData.identifier = channel.identifier
        
        backgroundContex.perform {
            if self.backgroundContex.hasChanges {
                do {
                    try self.backgroundContex.save()
                } catch let error as NSError {
                    self.backgroundContex.rollback()
                    print(error.debugDescription)
                }
            }
            self.backgroundContex.reset()
        }
    }
    
    func getChannelsFromCoreData() {
        let fetchRequest: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        do {
            let channelData = try contex.fetch(fetchRequest)
            print(channelData)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    // MARK: CoreData for messages
    
    func saveMessagesWithCoreData(message: Message, channel: ChannelModel?) {
        backgroundContex.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        backgroundContex.shouldDeleteInaccessibleFaults = true
        backgroundContex.automaticallyMergesChangesFromParent = true
        
        guard let messageObject = NSEntityDescription.entity(forEntityName: "DBMessage", in: contex) else {return}
        let messageData = DBMessage(entity: messageObject, insertInto: contex)
        
        messageData.senderName = message.senderName
        messageData.created = message.created
        messageData.senderId = message.senderid
        messageData.content = message.content

        let fetchRequest: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        guard let identifierChannel = channel?.identifier else {return}
        
        let predicate = NSPredicate(format: "identifier == %@", identifierChannel)
        fetchRequest.predicate = predicate
        fetchRequest.includesSubentities = true
        
        do {
            let channelData = try contex.fetch(fetchRequest)
            channelData.first?.addToMessage(messageData)
        } catch let error as NSError {
            print(error.debugDescription)
        }
        backgroundContex.perform {
            if self.backgroundContex.hasChanges {
                do {
                    try self.backgroundContex.save()
                } catch let error as NSError {
                    self.backgroundContex.rollback()
                    print(error.debugDescription)
                }
            }
            self.backgroundContex.reset()
        }
    }
    
    func getMessagesFromCoreData() {
        let fetchRequest: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        do {
            let messageData = try contex.fetch(fetchRequest)
            print(messageData)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
}
