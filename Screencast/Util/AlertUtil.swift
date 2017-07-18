//
//  AlertUtil.swift
//  Screencast
//
//  Created by Geovanny Zuniga on 17/7/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit

class AlertUtil: NSObject {
    
    static func showAlert(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

}
