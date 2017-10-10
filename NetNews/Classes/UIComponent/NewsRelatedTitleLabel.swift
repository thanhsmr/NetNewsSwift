//
//  NewsRelatedTitleLabel.swift
//  NetNews
//
//  Created by Thanhbv on 9/7/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit


class NewsRelatedTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.black
        self.font = Constants.Font.NewsRelatedTitleFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.black
        self.font = Constants.Font.NewsRelatedTitleFont
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = UIColor.black
        self.font = Constants.Font.NewsRelatedTitleFont
    }
}
