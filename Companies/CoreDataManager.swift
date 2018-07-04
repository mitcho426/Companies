//
//  CoreDataManager.swift
//  Companies
//
//  Created by bwong on 6/28/18.
//  Copyright © 2018 mwong. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Companie_Models")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed \(err)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let fetchError {
            print("Failed to fetch companies:", fetchError)
            return []
        }
    }
    
    func handleReset(companies: [Company]) -> [IndexPath] {
        let context = self.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            var indexPathsToRemove = [IndexPath]()
            for(index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section:0)
                indexPathsToRemove.append(indexPath)
            }
            return indexPathsToRemove
        } catch let deleteError {
            print("Failed to delete objects from Core Data:", deleteError)
            return []
        }
    }
}
