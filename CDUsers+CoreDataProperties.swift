//
//  CDUsers+CoreDataProperties.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 11/12/22.
//
//

import Foundation
import CoreData


extension CDUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUsers> {
        return NSFetchRequest<CDUsers>(entityName: "CDUsers")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension CDUsers : Identifiable {
    func convertToUserModel() -> UserModel {
        return UserModel(username: self.username, email: self.email, password: self.password)
    }
}
