//
//  MoreDetailLabel.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class MoreDetailLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.black
        self.font = Constants.Font.MenuTitleFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.black
        self.font = Constants.Font.MenuTitleFont
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = UIColor.black
        self.font = Constants.Font.MenuTitleFont
    }
    
    

}
