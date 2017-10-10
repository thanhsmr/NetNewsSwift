//
//  TopNowTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/12/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary

protocol TopNowTableViewCellDelegate {
    func topNowArticleTouch(article : ArticleObject)
    func sourceTouch(id : Int)
}

class TopNowTableViewCell: BaseTableViewCell {

    @IBOutlet weak var viewSourceName: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var imageSecond: UIImageView!
    @IBOutlet weak var imageThird: UIImageView!
    @IBOutlet weak var lbTitleFrist: UILabel!
    @IBOutlet weak var lbTitleSecond: UILabel!
    @IBOutlet weak var lbTitleThird: UILabel!
    
    var delegate: TopNowTableViewCellDelegate?
    var topNow : TopNowObject?
    
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
        if data is TopNowObject {
            let topNow = data as! TopNowObject
            self.topNow = topNow
            
            if let listArticle = topNow.articles {
                
                if listArticle.count > 0 {
                    let firstArticle = listArticle[0]
                    if let imageUrl = firstArticle.image {
                        imageFirst.setImage(url: URL.init(string: imageUrl), placeholder: UIImage.init(named: "video_place_holder"))
                    }
                    lbTitleFrist.text = firstArticle.title
                }
                
                if listArticle.count > 1 {
                    let secondArticle = listArticle[1]
                    if let imageUrl = secondArticle.image {
                        imageSecond.setImage(url: URL.init(string: imageUrl), placeholder: UIImage.init(named: "video_place_holder"))
                    }
                    lbTitleSecond.text = secondArticle.title
                }
                
                if listArticle.count > 2 {
                    let thirdArticle = listArticle[2]
                    if let imageUrl = thirdArticle.image {
                        imageThird.setImage(url: URL.init(string: imageUrl), placeholder: UIImage.init(named: "video_place_holder"))
                    }
                    lbTitleThird.text = thirdArticle.title
                }

            }
            
            if let hexString = topNow.color {
                viewSourceName.backgroundColor = UIColor.init(hexString: hexString)
            }
            
            if let iconUrl = topNow.icon {
                imageTitle.setImage(url: URL.init(string: iconUrl), placeholder: UIImage.init(named: "video_place_holder"))
            } else {
                imageTitle.image = UIImage.init(named: "video_place_holder")
            }
            
            updateScreenMode()
            
        }
    }
    
    @IBAction func firstArticleTouch(_ sender: Any) {
        if let firstArticle = self.topNow?.articles?[0] {
            delegate?.topNowArticleTouch(article: firstArticle)
        }
    }
    
    @IBAction func secondArticleTouch(_ sender: Any) {
        if let secondArticle = self.topNow?.articles?[1] {
            delegate?.topNowArticleTouch(article: secondArticle)
        }
    }

    @IBAction func thirdArticleTouch(_ sender: Any) {
        if let thirdArticle = self.topNow?.articles?[2] {
            delegate?.topNowArticleTouch(article: thirdArticle)
        }
    }
    @IBAction func sourceTouch(_ sender: Any) {
        if let topNow = self.topNow {
            delegate?.sourceTouch(id: topNow.categoryId)
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbTitleFrist)
        updateLabelForScreenMode(label: lbTitleSecond)
        updateLabelForScreenMode(label: lbTitleThird)
        updateViewForScreenMode(view: mainView)
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
    }
}
