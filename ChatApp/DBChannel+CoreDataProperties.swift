//
//  DBChannel+CoreDataProperties.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 30.10.2021.
//
//

import Foundation
import CoreData

extension DBChannel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBChannel> {
        return NSFetchRequest<DBChannel>(entityName: "DBChannel")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var name: String?
    @NSManaged public var lastMessage: String?
    @NSManaged public var lastActivity: Date?
    @NSManaged public var message: NSSet?

}

// MARK: Generated accessors for message
extension DBChannel {

    @objc(addMessageObject:)
    @NSManaged public func addToMessage(_ value: DBMessage)

    @objc(removeMessageObject:)
    @NSManaged public func removeFromMessage(_ value: DBMessage)

    @objc(addMessage:)
    @NSManaged public func addToMessage(_ values: NSSet)

    @objc(removeMessage:)
    @NSManaged public func removeFromMessage(_ values: NSSet)

}
