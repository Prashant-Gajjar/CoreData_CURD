//
//  UserModel.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 10/12/22.
//

import Foundation

class UserModel {
    let username        : String
    let email           : String
    let password        : String
    let id              : UUID
    let profileImage    : Data
    
    var subscription    : SubscriptionModel?
    
    init(username: String, email: String, password: String, id: UUID, profileImage: Data, subscription: SubscriptionModel? = nil) {
        self.username = username
        self.email = email
        self.password = password
        self.id = id
        self.profileImage = profileImage
        self.subscription = subscription
    }
}
