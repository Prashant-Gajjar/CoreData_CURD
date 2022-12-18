//
//  PersistentStorage.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 11/12/22.
//

import CoreData

final class PersistentStorage {
    //MARK: - Properties
    static let shared = PersistentStorage()
   
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataCURD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedContext = persistentContainer.viewContext
        
    //MARK: - LifeCycle
    private init() {
        print("documentDirectoryFile: ",FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //MARK: - Methods
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nsError = error as NSError
                print(" ---- ❌ ---- ")
                print("Error while saving ",nsError)
                print("UserInfo Error ",nsError.userInfo)
                print("Localised Error ",nsError.localizedDescription)
                print(" ---- ❌ ---- ")
                fatalError()
            }
        }
    }
    
    func entity(_ entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let results = try PersistentStorage.shared.managedContext.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            return results
        } catch {
            print("Error while retrieving: ", error)
        }
        return nil
    }
    
    func fetchRequest(_ fetchEntityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: fetchEntityName)
    }
}
