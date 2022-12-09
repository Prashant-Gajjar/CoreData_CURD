//
//  CoreDataCURDManager.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import CoreData

class CDManager {
    //MARK: - Properties
    static let shared = CDManager()
        
    private var persistentContainer : NSPersistentContainer!
    private var managedContext      : NSManagedObjectContext!
    
    //MARK: - LifeCycle
    private init() {
        let container = NSPersistentContainer(name: "CoreDataCURD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
        managedContext = container.viewContext
    }
    
    //MARK: - Methods
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
    
    func fetchRequest(_ fetchEntityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: fetchEntityName)
    }
}

//MARK: - CURD Operation
extension CDManager {
    //Save Data
    func save(_ value       : Any?,
              attributeName : String,
              entityName    : String) {
        let user = NSManagedObject(entity: entity(entityName), insertInto: managedContext)
        user.setValue(value, forKey: attributeName)
        
        saveContext()
    }
    
    ///Retrieve data
    func nsFetchRequestResultDataFrom(entityName    : String,
                                      attributeName : String,
                                      predicate     : NSPredicate? = nil) -> [NSFetchRequestResult]? {
        let fetchReq = fetchRequest(entityName)
        fetchReq.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchReq)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: attributeName) as! String)
            }
            
            return result
            
        } catch {
            print("failed: ", error.localizedDescription)
            return nil
        }
    }
    
    //Update data
    func updateDataFrom(_ fetchRequestResults : [NSFetchRequestResult],
                        set value             : Any?,
                        attributeName         : String,
                        at index              : Int) {
        let object = fetchRequestResults[index] as! NSManagedObject
        object.setValue(value, forKey: attributeName)
        
        saveContext()
    }
    
    ///Delete data
    func deleteDataFrom(_ fetchRequestResults : [NSFetchRequestResult],
                        at index              : Int) {
        let objectToDelete = fetchRequestResults[index] as! NSManagedObject
        managedContext.delete(objectToDelete)
        
        saveContext()
    }
}
