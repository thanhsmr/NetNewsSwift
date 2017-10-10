//
//  LoadingExtension.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//


import Foundation
import UIKit
import MBProgressHUD

private var loadingViewAssociationKey: UInt8 = 0

extension UIViewController {
    
    private struct AssociatedKeys {
        static var loadingView:UIView?
    }
    
    var loadingView: UIView! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIView
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.loadingView, newValue as UIView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func showLoading() {
        if self.loadingView == nil {
            self.loadingView = UIView(frame: (self.view.bounds))
        }
        
        self.view.addSubview(self.loadingView)
        let hud = MBProgressHUD.showAdded(to: self.loadingView, animated: true)
        hud.bezelView.backgroundColor = UIColor.black
        hud.bezelView.alpha = 0.8
        hud.contentColor = UIColor.white
    }

    func stopLoading() {
        DispatchQueue.main.safeAsync {
            self.loadingView?.removeFromSuperview()
            
            if let loadingView = self.loadingView {
                MBProgressHUD.hide(for: loadingView, animated: true)
            }
        }
    }
    
    func showLoadingInScreenCenter(){
        if let window = UIApplication.shared.delegate?.window{
            if self.loadingView == nil {
                self.loadingView = UIView(frame: (window?.bounds) ?? CGRect.zero)
            }
            
            window?.addSubview(self.loadingView)
            let hud = MBProgressHUD.showAdded(to: self.loadingView, animated: true)
            hud.bezelView.backgroundColor = UIColor.black
            hud.bezelView.alpha = 0.8
            hud.contentColor = UIColor.white
        }
    }
    
    func showFailPopupWithText(text: String, delegate: BaseViewController? = nil) {
        if let view = self.navigationController?.view ?? self.view {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            if let dlgate = delegate {
                hud.delegate = dlgate as? MBProgressHUDDelegate
            }
            hud.mode = .customView
            hud.bezelView.backgroundColor = UIColor.black
            hud.bezelView.alpha = 0.8
            let imageView = UIImageView(image: #imageLiteral(resourceName: "alert_error"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x:0, y:0, width:30, height:30)
            hud.customView = imageView
            hud.label.text = text
            hud.label.textColor = UIColor.white
            hud.label.numberOfLines = 0
            hud.margin = 10
            hud.hide(animated: true, afterDelay: 2)
        }
    }
    
    func showSuccessPopupWithText(text: String = "Success!", delegate: BaseViewController? = nil, isAddWindow: Bool? = nil) {
        if let view = self.navigationController?.view, let window = UIApplication.shared.windows.last {
            
            var hud : MBProgressHUD!
            if let isAdd = isAddWindow, isAdd == true {
                
                hud = MBProgressHUD.showAdded(to: window, animated: true)
                
            } else {
                
                hud = MBProgressHUD.showAdded(to: view, animated: true)
                
            }
            
            
            if let dlgate = delegate {
                hud.delegate = dlgate as? MBProgressHUDDelegate
            }
            hud.mode = .customView
            hud.bezelView.backgroundColor = UIColor.black
            hud.bezelView.alpha = 0.8
            let imageView = UIImageView(image: #imageLiteral(resourceName: "alert_ok"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x:0, y:0, width:30, height:30)
            hud.customView = imageView
            hud.label.text = text
            hud.label.numberOfLines = 0
            hud.label.textColor = UIColor.white
            hud.hide(animated: true, afterDelay: 2)
            
        }
    }
}
