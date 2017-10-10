//
//  NewsPictureTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewsPictureTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imageMain: UIImageView!
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
            imageMain.setImage(url: URL.init(string: (data as! BodyDetailArticle).content!) , placeholder: UIImage.init(named: "video_place_holder"))
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView)
    }
    
}
