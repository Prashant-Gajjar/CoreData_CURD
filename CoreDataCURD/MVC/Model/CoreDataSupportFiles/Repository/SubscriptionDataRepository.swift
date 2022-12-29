//
//  SubscriptionDataRepository.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 28/12/22.
//

import Foundation

protocol SubscriptionRepository: BaseCURDRepository {
    
}

//MARK: - UsersDataRepository
struct SubscriptionDataRepository: SubscriptionRepository {
    
    typealias CD = CDSubscription
    
    typealias T = SubscriptionModel

    func create(record: SubscriptionModel) {
        let cdSub = CDSubscription(context: PersistentStorage.shared.managedContext)
        cdSub.subscriptionId   = record.subscriptionId
        cdSub.id               = record.id
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [SubscriptionModel]? {
        let results = PersistentStorage.shared.fetchManagedObject(managedObject: CDSubscription.self)
        
        var subs = [SubscriptionModel]()
        
        results?.forEach({ subs.append($0.convertToSubscriptionModel()) })
        
        return subs
    }
    
    func getRecord(byIdentifier id: UUID) -> SubscriptionModel? {
        return self.getCDRecord(byIdentifier: id)?.convertToSubscriptionModel()
    }
        
    func update(record: SubscriptionModel) -> Bool {
        guard let cdSub = getCDRecord(byIdentifier: record.id) else { return false }
        
        cdSub.subscriptionId    = record.subscriptionId
        cdSub.id                = record.id
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func delete(id: UUID) -> Bool {
        guard let cdSub = getCDRecord(byIdentifier: id) else { return false }
        
        PersistentStorage.shared.managedContext.delete(cdSub)
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
}
