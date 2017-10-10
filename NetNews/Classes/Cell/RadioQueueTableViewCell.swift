//
//  RadioQueueTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/13/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary

protocol RadioQueueTableViewCellDelegate {
    func touchRadio(article : ArticleObject?)
}


class RadioQueueTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbTitle: RadioTitleLabel!
    
    var delegate : RadioQueueTableViewCellDelegate?
    var article : ArticleObject?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configWithData(data: Any) {
        if data is ArticleObject {
            let data = data as! ArticleObject
            self.article = data
            if let imageUrl = data.image169 {
                imageMain.setImage(url: URL.init(string: imageUrl), placeholder: UIImage.init(named: "video_place_holder"))
            } else {
                imageMain.image = UIImage.init(named: "video_place_holder")
            }
            lbTitle.text = data.title
            
            updateScreenMode()
        }
    }
    
    func hightlightCell(isHightlight: Bool) {
        if isHightlight {
            lbTitle.textColor = Constants.Color.RadioTitleHighlightColor
        } else {
            if Context.getScreenMode() {
                lbTitle.textColor = UIColor.white
            } else {
                lbTitle.textColor = UIColor.black
            }
        }
    }
    
    @IBAction func touchArticle(_ sender: Any) {
        delegate?.touchRadio(article: self.article)
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView)
        updateLabelForScreenMode(label: lbTitle)
    }
}
