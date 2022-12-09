//
//  AppDelegate.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate {

    //MARK: - Properties
    var window: UIWindow?

    //MARK: - AppDelegate Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CDManager.shared.saveContext()
    }
    
}
