//
//  CDSubscription+extensions.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 28/12/22.
//

import Foundation

extension CDSubscription {
    func convertToSubscriptionModel() -> SubscriptionModel{
        return SubscriptionModel(username       : self.toUser?.username,
                                 id             : self.id!,
                                 subscriptionId : self.subscriptionId!)
    }
}
