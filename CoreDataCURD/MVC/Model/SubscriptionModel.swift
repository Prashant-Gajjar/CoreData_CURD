//
//  SubscriptionModel.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 28/12/22.
//

import Foundation

class SubscriptionModel {
    
    let username: String?
    let id: UUID
    let subscriptionId: String?

    init(username: String? = nil, id: UUID, subscriptionId: String?) {
        self.username           = username
        self.id                 = id
        self.subscriptionId     = subscriptionId
    }
}
