//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.11.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores { (persistent, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(persistent.url ?? "")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    lazy var contex: NSManagedObjectContext = persistentContainer.viewContext
    lazy var backgroundContex: NSManagedObjectContext = persistentContainer.newBackgroundContext()
 
    func saveContex() {
        if backgroundContex.hasChanges {
            do {
                try backgroundContex.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


