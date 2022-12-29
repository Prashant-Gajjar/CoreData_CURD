//
//  CDUser+extension.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 18/12/22.
//

import Foundation

extension CDUser {
    func convertToUserModel() -> UserModel {
        return UserModel(username       : self.username!,
                         email          : self.email!,
                         password       : self.password!,
                         id             : self.id!,
                         profileImage   : self.profileImage!,
                         subscription   : self.toSubscription?.convertToSubscriptionModel())
    }
}
