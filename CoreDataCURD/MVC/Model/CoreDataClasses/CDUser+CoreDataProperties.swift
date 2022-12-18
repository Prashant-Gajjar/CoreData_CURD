//
//  CDUser+CoreDataProperties.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 18/12/22.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var profileImage: Data?

}

extension CDUser : Identifiable {

}
