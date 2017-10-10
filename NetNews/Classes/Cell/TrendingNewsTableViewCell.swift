//
//  TrendingNewsTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/15/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

protocol TrendingNewsTableViewCellDelegate {
    func articleTouch(article: ArticleObject)
}


class TrendingNewsTableViewCell: BaseTableViewCell {

    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    var article: ArticleObject?
    var delegate: TrendingNewsTableViewCellDelegate?
    static let heightCell:CGFloat = 52.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchArticle(_ sender: Any) {
        if let article = self.article {
            delegate?.articleTouch(article: article)
        }
    }
    
    override func configWithData(data: Any) {
        if data is (Int , ArticleObject) {
            self.article = (data as! (Int , ArticleObject)).1
            lbTitle.text = self.article?.title
            lbIndex.text = String.init(format: "%d", (data as! (Int , ArticleObject)).0)
            if (data as! (Int , ArticleObject)).0 >= 4 {
                lbIndex.backgroundColor = UIColor.init(red: 158/255.0, green: 158/255.0, blue: 158/255.0, alpha: 1.0)
            }
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: self.viewMain)
        updateLabelForScreenMode(label: lbTitle)
    }
}
