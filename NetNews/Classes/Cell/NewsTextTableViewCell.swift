//
//  NewsTextTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewsTextTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configWithData(data: Any) {
        if data is BodyDetailArticle {
            lbContent.attributedText = (data as! BodyDetailArticle).contentAtributeString
            let currentFont = lbContent.font
            lbContent.font = currentFont?.withSize(18)
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbContent)
        updateViewForScreenMode(view: self.contentView)
    }
    
}
