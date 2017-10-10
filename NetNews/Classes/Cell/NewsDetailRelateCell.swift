//
//  NewsDetailRelateCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/7/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary

protocol NewsDetailRelateCellDelegate {
    func articleTouch(article: ArticleObject)
}

class NewsDetailRelateCell: BaseTableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbTitle: NewsRelatedTitleLabel!
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbNewspaperName: NewspaperNameLabel!
    @IBOutlet weak var listenBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var listenButtonView: ListenButtonView!
    
    var article: ArticleObject?
    var delegate: NewsDetailRelateCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Constants.Color.TableViewBackground
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configWithData(data: Any) {
        if data is ArticleObject {
            let article = data as! ArticleObject
            self.article = article
            lbTitle.text = article.title
            lbNewspaperName.text = article.sourceName?.uppercased()
            imageMain.setImage(url: URL.init(string: article.image!), placeholder: UIImage.init(named: "video_place_holder"))
            
            if let readAvaible = article.isNghe {
                if readAvaible.boolValue {
                    //read news avaible
                    listenBtnHeight.constant = 35
                    listenButtonView.isHidden = false
                    listenButtonView.configWithData(article: article)
                } else {
                    //read news not avaible
                    listenBtnHeight.constant = 0
                    listenButtonView.isHidden = true
                }
            } else {
                //read news not avaible
                listenBtnHeight.constant = 0
                listenButtonView.isHidden = true
            }
            
            updateScreenMode()
        }
    }
    
    @IBAction func articleTouch(_ sender: Any) {
        delegate?.articleTouch(article: self.article!)
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbTitle)
        updateLabelForScreenMode(label: lbNewspaperName, colorOfNotDarkMode: Constants.Color.NewsPaperNameColor)
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: mainView)
    }
    

}
