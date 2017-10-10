//
//  OverViewTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/15/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary

protocol OverViewTableViewCellDelegate {
    func articleTouch(article: ArticleObject)
}

class OverViewTableViewCell: BaseTableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imageMain: UIImageView!
    var article: ArticleObject?
    var delegate: OverViewTableViewCellDelegate?
    static let heightCell: CGFloat = 60.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchArticle(_ sender: Any) {
        delegate?.articleTouch(article: self.article!)
    }
    
    override func configWithData(data: Any) {
        if data is ArticleObject {
            self.article = data as? ArticleObject
            lbTitle.text = self.article?.title
            if let imageUrl = self.article?.image169 {
                imageMain.setImage(url: URL.init(string: imageUrl), placeholder: UIImage.init(named: "video_place_holder"))
            }
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: self.mainView)
        updateLabelForScreenMode(label: lbTitle)
    }
    
}
