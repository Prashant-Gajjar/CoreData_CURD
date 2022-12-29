//
//  UsersDataRepository.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 11/12/22.
//

import Foundation

protocol UsersRepository: BaseCURDRepository {
    
}

//MARK: - UsersDataRepository
struct UsersDataRepository: UsersRepository {
    
    typealias CD = CDUser
    
    typealias T = UserModel

    func create(record: UserModel) {
        let cdUsers = CDUser(context: PersistentStorage.shared.managedContext)
        cdUsers.username        = record.username
        cdUsers.email           = record.email
        cdUsers.password        = record.password
        cdUsers.id              = record.id
        cdUsers.profileImage    = record.profileImage
        
        if let sub = record.subscription {
            let cdSub = CDSubscription(context: PersistentStorage.shared.managedContext)
            cdSub.subscriptionId    = sub.subscriptionId
            cdSub.id                = sub.id
            
            cdUsers.toSubscription  = cdSub
        }
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [UserModel]? {
        let results = PersistentStorage.shared.fetchManagedObject(managedObject: CDUser.self)
        
        var users = [UserModel]()
        
        results?.forEach({ users.append($0.convertToUserModel()) })
        
        return users
    }
    
    func getRecord(byIdentifier id: UUID) -> UserModel? {
        return getCDRecord(byIdentifier: id)?.convertToUserModel()
    }
        
    func update(record: UserModel) -> Bool {
        guard let cdUser = getCDRecord(byIdentifier: record.id) else { return false }
        
        cdUser.username         = record.username
        cdUser.email            = record.email
        cdUser.password         = record.password
        cdUser.id               = record.id
        cdUser.profileImage     = record.profileImage
        
        if let sub = record.subscription {
            if let cdSub = cdUser.toSubscription {
                cdSub.subscriptionId = sub.subscriptionId
            } else {
                let subRepo = SubscriptionDataRepository()
                subRepo.create(record: SubscriptionModel(id             : sub.id,
                                                         subscriptionId : sub.subscriptionId))
                cdUser.toSubscription = subRepo.getCDRecord(byIdentifier: sub.id)
            }
        }
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func delete(id: UUID) -> Bool {
        guard let cdUser = getCDRecord(byIdentifier: id) else { return false }
        
        PersistentStorage.shared.managedContext.delete(cdUser)
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
}
