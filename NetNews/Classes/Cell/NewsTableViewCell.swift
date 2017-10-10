//
//  NewsTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary

protocol NewsTableViewCellDelegate {
    func articleTouch(article: ArticleObject)
    func listenTouch()
}

class NewsTableViewCell: BaseTableViewCell, ListenButtonViewDelegate {

    
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbTitle: NewsTitleLabel!
    @IBOutlet weak var lbNewspaperName: NewspaperNameLabel!
    @IBOutlet weak var lbTitleSub: NewsSubTitleLabel!
    @IBOutlet weak var listenButtonView: ListenButtonView!

    @IBOutlet weak var parentListenButtonView: UIView!
    @IBOutlet weak var mainView: UIView!
    

    @IBOutlet weak var btnListenHeight: NSLayoutConstraint!
    var delegate : NewsTableViewCellDelegate?
    var article: ArticleObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listenButtonView.delegate = self
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
            imageMain.setImage(url: URL.init(string: (article.image)!), placeholder: UIImage.init(named: "video_place_holder"))
            lbNewspaperName.text = article.sourceName?.uppercased()
            lbTitleSub.text = article.sapo
            if let readAvaible = article.isNghe {
                if readAvaible.boolValue {
                    //read news avaible
                    btnListenHeight.constant = 35
                    listenButtonView.isHidden = false
                    listenButtonView.configWithData(article: self.article!)
                } else {
                    //read news not avaible
                    btnListenHeight.constant = 0
                    listenButtonView.isHidden = true
                }
            } else {
                //read news not avaible
                btnListenHeight.constant = 0
                listenButtonView.isHidden = true
            }
            
            updateScreenMode()
        }
    }
    
    
    @IBAction func articleTouch(_ sender: Any) {
        delegate?.articleTouch(article: article!)
    }

    func listenButtonTouch() {
        delegate?.listenTouch()
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbTitle)
        updateLabelForScreenMode(label: lbNewspaperName, colorOfNotDarkMode: Constants.Color.NewsPaperNameColor)
        updateLabelForScreenMode(label: lbTitleSub)
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: mainView)
        updateViewForScreenMode(view: parentListenButtonView)
    }
}
