//
//  NewsTitle.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewsTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.black
        self.font = Constants.Font.NewsTitleFont
        self.textAlignment = .justified
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.black
        self.font = Constants.Font.NewsTitleFont
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = UIColor.black
        self.font = Constants.Font.NewsTitleFont
    }
}
