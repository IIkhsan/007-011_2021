//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 23.11.2021.
//

import Foundation
import CoreData

final class PersistableService {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "007-011_2021")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support

    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

