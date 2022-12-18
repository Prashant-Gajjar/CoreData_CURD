//
//  AppUtil.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 10/12/22.
//

import UIKit

struct Constant {
    static let shared = Constant()
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}

struct Function {
    //validations
    static func check(txtField: UITextField) -> (isValid: Bool, txt: String) {
        if let text = txtField.text {
            if text.count != 0 {
                return (true, text)
            }
        }
        return (false, "")
    }
    
    static func validationAlert(for txtFieldName: String) {
        Function.showAlert(title: "Validation!", "Please enter \(txtFieldName)")
    }
    
    static func showAlert(title: String = "CorData Manager App",
                          _ msg: String?) {
        let ac = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Okay", style: .cancel, handler: nil)
        ac.addAction(ok)
        Constant.appDelegate.window?.rootViewController?.present(ac, animated: true, completion: nil)
    }
}
