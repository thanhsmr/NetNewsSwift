//
//  NewsSubTitleLabel.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewsSubTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = Constants.Color.NewsSubTitleColor
        self.font = Constants.Font.NewsSubTitleFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = Constants.Color.NewsSubTitleColor
        self.font = Constants.Font.NewsSubTitleFont
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = Constants.Color.NewsSubTitleColor
        self.font = Constants.Font.NewsSubTitleFont
    }

}
