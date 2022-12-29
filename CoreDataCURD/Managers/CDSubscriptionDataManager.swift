//
//  CDSubscriptionDataManager.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import CoreData

struct CDSubscriptionDataManager {
    //MARK: - Properties
    static let shared = CDSubscriptionDataManager(sdr: SubscriptionDataRepository())
    
    private var _sdr: SubscriptionDataRepository!
    
    //MARK: - LifeCycle
    private init(sdr: SubscriptionDataRepository) {
        self._sdr = sdr
    }
}

//MARK: - CURD Operation
extension CDSubscriptionDataManager {
    func create(record: SubscriptionModel) {
        _sdr.create(record: record)
    }
    func fetchAllRecord() -> [SubscriptionModel]? {
        return _sdr.getAll()
    }
    func fetchRecord(by id: UUID) -> SubscriptionModel? {
        return _sdr.getRecord(byIdentifier: id)
    }
    func update(record: SubscriptionModel) -> Bool {
        return _sdr.update(record: record)
    }
    func deleteRecord(by id: UUID) -> Bool {
        return _sdr.delete(id: id)
    }
}
