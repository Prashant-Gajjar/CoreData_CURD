//
//  BaseCURDRepository.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 28/12/22.
//

import Foundation
import CoreData


protocol BaseCURDRepository {
    
    associatedtype T
    associatedtype CD: NSManagedObject
    
    func create(record: T)
    func getAll() -> [T]?
    func getRecord(byIdentifier id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(id: UUID) -> Bool
}

extension BaseCURDRepository {
    func getCDRecord(byIdentifier id: UUID) -> CD? {
        let fetchRequest = CD.fetchRequest()
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.managedContext.fetch(fetchRequest).first
            
            guard result != nil else { return nil }
            
            return result as? Self.CD
        } catch {
            print("Error while retrieving: ", error)
        }
        
        return nil
    }
}
