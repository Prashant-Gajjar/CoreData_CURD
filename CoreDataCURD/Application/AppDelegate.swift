//
//  AppDelegate.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate {

    //MARK: - Properties
    var window: UIWindow?

    //MARK: - AppDelegate Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        PersistentStorage.shared.saveContext()
    }
    
}
