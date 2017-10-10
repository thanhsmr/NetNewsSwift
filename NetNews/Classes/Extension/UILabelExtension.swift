//
//  UILabelExtension.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import UIKit

extension UILabel {
    func format(){
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
    
    func formatSize(size: CGFloat) {
        self.format()
        self.font = UIFont(name: self.font.fontName, size: size)
    }
    
    func formatBoldSize(size: CGFloat) {
        self.format()
        self.font = UIFont.boldSystemFont(ofSize: size)
    }
    
//    func formatMediumSize(size: CGFloat) {
//        self.format()
//        self.font = UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
//    }
}
