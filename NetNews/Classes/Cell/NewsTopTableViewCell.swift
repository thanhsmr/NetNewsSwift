//
//  NewsTopTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

protocol NewsTopTableViewCellDelegate {
    func articleTouch(article: ArticleObject)
    func listenTouch()
}

class NewsTopTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbTitle: NewsTitleLabel!
    @IBOutlet weak var mainView: UIView!
    
    var delegate : NewsTopTableViewCellDelegate?
    var article: ArticleObject?
    
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
            imageMain.setImage(url: URL.init(string: (article.image)!), placeholder: UIImage.init(named: "video_place_holder"))
            
            updateScreenMode()
        }
        
    }
    
    @IBAction func articleTouch(_ sender: Any) {
        delegate?.articleTouch(article: self.article!)
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbTitle)
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: mainView)
    }
    
}

