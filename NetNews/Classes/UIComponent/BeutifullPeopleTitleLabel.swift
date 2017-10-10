//
//  BeutifullPeopleTitleLabel.swift
//  NetNews
//
//  Created by Thanhbv on 9/14/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class BeutifullPeopleTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.white
        self.font = Constants.Font.NewsTitleFont
        self.textAlignment = .justified
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.white
        self.font = Constants.Font.NewsTitleFont
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = UIColor.white
        self.font = Constants.Font.NewsTitleFont
    }

}
