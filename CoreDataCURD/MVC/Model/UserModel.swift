//
//  UserModel.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 10/12/22.
//

import Foundation
import CoreData

struct UserModel {    
    var username        : String?
    var email           : String?
    var password        : String?
    var id              : UUID
    var profileImage    : Data?
}
