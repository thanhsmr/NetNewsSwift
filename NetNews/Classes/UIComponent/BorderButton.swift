//
//  BorderButton.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
    }
    
    func setON() {
        self.backgroundColor = UIColor.darkGray
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setOFF() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.black, for: .normal)
    }
}
