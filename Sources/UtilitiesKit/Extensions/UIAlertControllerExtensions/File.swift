//
//  UIAlertController.swift
//  
//  Created by Moamen on 24/11/2023.
//

import UIKit

public extension UIAlertController {
    
    class func showAlert(tintColor: UIColor = .haileyBlueColor, title: String, message: String, actionTitle: String = "alert_ok_key".localized, dismissTitle: String? = "alert_cancel_key".localized, actionCompletion: ((UIAlertAction) -> Void)? = nil, cancelCompletion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.view.tintColor = tintColor
        
        let actionButton = UIAlertAction(title: actionTitle, style: .default, handler: { (alertAction) in
            actionCompletion?(alertAction)
        })
        alertController.addAction(actionButton)
        
        if dismissTitle != nil {
            let cancelButton = UIAlertAction(title: dismissTitle, style: .default, handler: { (cancelAction) in
                cancelCompletion?(cancelAction)
            })
            alertController.addAction(cancelButton)
        }
        
        if let topVC = UIApplication.topViewController() {
            topVC.present(alertController, animated: true)
        }
    }
}
