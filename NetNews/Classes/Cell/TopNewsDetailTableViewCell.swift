//
//  TopNewsDetailTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class TopNewsDetailTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var listenButtonView: ListenButtonView!
    @IBOutlet weak var listenButtonViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lbNewspaper: UILabel!
    @IBOutlet weak var parentListenButtonView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbTitle.textColor = Constants.Color.NewsDetailTopTitleColor
        lbTime.textColor = Constants.Color.NewsDetailTopTimeColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func configWithData(data: Any) {
        if data is ArticleObject {
            let headerObject = data as! ArticleObject
            lbTime.text = headerObject.date?.htmlToString
            lbTitle.text = headerObject.title
            lbDescription.text = headerObject.sapo
            lbNewspaper.text = headerObject.sourceName?.uppercased()
            
            if let readAvaible = headerObject.isNghe {
                if readAvaible.boolValue {
                    //read news avaible
                    listenButtonViewHeight.constant = 30
                    listenButtonView.isHidden = false
                    listenButtonView.configWithData(article: headerObject)
                } else {
                    //read news not avaible
                    listenButtonViewHeight.constant = 0
                    listenButtonView.isHidden = true
                }
            } else {
                //read news not avaible
                listenButtonViewHeight.constant = 0
                listenButtonView.isHidden = true
            }
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbTitle, colorOfNotDarkMode: Constants.Color.NewsDetailTopTitleColor)
        updateLabelForScreenMode(label: lbTime, colorOfNotDarkMode: Constants.Color.NewsDetailTopTimeColor)
        updateLabelForScreenMode(label: lbNewspaper, colorOfNotDarkMode: Constants.Color.NewsPaperNameColor)
        updateLabelForScreenMode(label: lbDescription)
        updateViewForScreenMode(view: self.contentView)
        updateViewForScreenMode(view: self.parentListenButtonView)
    }
    
}
