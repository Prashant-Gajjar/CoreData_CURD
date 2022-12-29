//
//  CDSubscription+CoreDataProperties.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 28/12/22.
//
//

import Foundation
import CoreData


extension CDSubscription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSubscription> {
        return NSFetchRequest<CDSubscription>(entityName: "CDSubscription")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var subscriptionId: String?
    @NSManaged public var toUser: CDUser?

}

extension CDSubscription : Identifiable {

}
