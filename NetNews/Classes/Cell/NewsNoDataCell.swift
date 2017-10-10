//
//  NewsNoDataCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/12/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewsNoDataCell: BaseTableViewCell {

    @IBOutlet weak var lbNote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configWithData(data: Any) {
        if data is String {
            lbNote.text = data as? String
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView)
        updateLabelForScreenMode(label: lbNote)
    }
    
}
