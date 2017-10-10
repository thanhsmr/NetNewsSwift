//
//  NewAuthorTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewAuthorTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lbAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configWithData(data: Any) {
        if data is BodyDetailArticle {
            lbAuthor.text = (data as! BodyDetailArticle).content!.htmlToString
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView)
        updateLabelForScreenMode(label: lbAuthor)
    }
    
}
