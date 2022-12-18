//
//  UsersDataRepository.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 11/12/22.
//

import Foundation

protocol UsersRepository {
    func create(user: UserModel)
    func getAll() -> [UserModel]?
    func getUserModel(byIdentifier id: UUID) -> UserModel?
    func update(user: UserModel) -> Bool
    func delete(id: UUID) -> Bool
}

//MARK: - UsersDataRepository
struct UsersDataRepository: UsersRepository {
    
    func create(user: UserModel) {
        let cdUsers = CDUser(context: PersistentStorage.shared.managedContext)
        cdUsers.username        = user.username
        cdUsers.email           = user.email
        cdUsers.password        = user.password
        cdUsers.id              = user.id
        cdUsers.profileImage    = user.profileImage
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [UserModel]? {
        let results = PersistentStorage.shared.fetchManagedObject(managedObject: CDUser.self)
        
        var users = [UserModel]()
        
        results?.forEach({ users.append($0.convertToUserModel()) })
        
        return users
    }
    
    func getUserModel(byIdentifier id: UUID) -> UserModel? {
        return getCDUsers(byIdentifier: id)?.convertToUserModel()
    }
    
    func update(user: UserModel) -> Bool {
        guard let cdUser = getCDUsers(byIdentifier: user.id) else { return false }
        
        cdUser.username         = user.username
        cdUser.email            = user.email
        cdUser.password         = user.password
        cdUser.id               = user.id
        cdUser.profileImage     = user.profileImage
        
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    func delete(id: UUID) -> Bool {
        guard let cdUser = getCDUsers(byIdentifier: id) else { return false }
        
        PersistentStorage.shared.managedContext.delete(cdUser)
        PersistentStorage.shared.saveContext()
        return true
    }
}

//MARK: - Methods
extension UsersDataRepository {
    private func getCDUsers(byIdentifier id: UUID) -> CDUser? {
        let fetchRequest = CDUser.fetchRequest()
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.managedContext.fetch(fetchRequest).first
            
            guard result != nil else { return nil }
            
            return result
        } catch {
            print("Error while retrieving: ", error)
        }
        
        return nil
    }
}
