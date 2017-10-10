//
//  Alert.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import UIKit

class Alert {
    class func alert(viewController: UIViewController, title: String, message: String, okTitle: String = "OK", cancelTitle: String? = nil, okAction:(() -> ())? = nil, cancelAction:(() -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { UIAlertAction in
            okAction?()
        }
        alertController.addAction(okAction)
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { UIAlertAction in
                cancelAction?()
            }
            alertController.addAction(cancelAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
