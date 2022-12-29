//
//  CDUsersDataManager.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import CoreData

struct CDUsersDataManager {
    //MARK: - Properties
    static let shared = CDUsersDataManager(udr: UsersDataRepository())
    
    private var _udr: UsersDataRepository!
    
    //MARK: - LifeCycle
    private init(udr: UsersDataRepository) {
        self._udr = udr
    }
}

//MARK: - CURD Operation
extension CDUsersDataManager {
    func create(user: UserModel) {
        _udr.create(record: user)
    }
    func fetchAllUser() -> [UserModel]? {
        return _udr.getAll()
    }
    func fetchUser(by id: UUID) -> UserModel? {
        return _udr.getRecord(byIdentifier: id)
    }
    func update(user: UserModel) -> Bool {
        return _udr.update(record: user)
    }
    func deleteUser(by id: UUID) -> Bool {
        return _udr.delete(id: id)
    }
}
