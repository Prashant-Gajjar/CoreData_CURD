//
//  UIViewController+Extension.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 17/12/22.
//

import UIKit

extension UIViewController {
    
    enum Storyboards : String {
        case main = "Main"
    }
    
    class func instantiateFromStoryboard(_ name: Storyboards) -> Self? {
        return instantiateFromStoryboardHelper(name.rawValue)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T: UIViewController>(_ name: String) -> T?{
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T {
            return controller
        }else{
            return nil
        }
    }
    
    func push(to vc: UIViewController, with animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func present(vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.present(vc, animated: animated, completion: completion)
    }
}
