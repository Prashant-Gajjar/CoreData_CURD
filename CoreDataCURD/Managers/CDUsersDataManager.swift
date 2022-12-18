//
//  CDUsersDataManager.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import CoreData

struct CDUsersDataManager {
    //MARK: - Properties
    static let shared = CDUsersDataManager()
    
    private let _udr = UsersDataRepository()
    
    //MARK: - LifeCycle
    private init() { }
}

//MARK: - CURD Operation
extension CDUsersDataManager {
    func create(user: UserModel) {
        _udr.create(user: user)
    }
    func fetchAllUser() -> [UserModel]? {
        return _udr.getAll()
    }
    func fetchUser(by id: UUID) -> UserModel? {
        return _udr.getUserModel(byIdentifier: id)
    }
    func update(user: UserModel) -> Bool {
        return _udr.update(user: user)
    }
    func deleteUser(by id: UUID) -> Bool {
        return _udr.delete(id: id)
    }
}
