//
//  RadioTitleLabel.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class RadioTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = Constants.Color.RadioTitleColor
        self.font = Constants.Font.RadioTitleFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = Constants.Color.RadioTitleColor
        self.font = Constants.Font.RadioTitleFont
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = Constants.Color.RadioTitleColor
        self.font = Constants.Font.RadioTitleFont
    }

}
