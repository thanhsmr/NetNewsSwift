//
//  UIViewExtension.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib(nibNameOrNil: String? = nil) -> UIView {
        var view: UIView?
        let name: String
        
        if let nibName = nibNameOrNil {
            name = nibName
        }
        else {
            name = "\(self)".components(separatedBy: ".").last!
        }
        
        if let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil) {
            for v in nibViews {
                if let v = v as? UIView {
                    view = v
                }
            }			
        }
        
        return view!
    }
    
    class func nibObject() -> UINib {
        let name = "\(self)".components(separatedBy: ".").last!
        let hasNib: Bool = Bundle.main.path(forResource: name, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Invalid parameter") // assert
            return UINib()
        }
        return UINib(nibName: name, bundle:nil)
    }
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(_ multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

