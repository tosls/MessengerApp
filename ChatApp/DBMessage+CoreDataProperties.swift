//
//  DBMessage+CoreDataProperties.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 30.10.2021.
//
//

import Foundation
import CoreData

extension DBMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMessage> {
        return NSFetchRequest<DBMessage>(entityName: "DBMessage")
    }

    @NSManaged public var content: String?
    @NSManaged public var created: Date?
    @NSManaged public var senderId: String?
    @NSManaged public var senderName: String?
    @NSManaged public var channel: DBChannel?

}
