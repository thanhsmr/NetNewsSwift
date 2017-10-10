//
//  NoteNewsTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/15/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

protocol NoteNewsTableViewCellDelegate {
    func articleTouch(article: ArticleObject)
}

class NoteNewsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    var article: ArticleObject?
    var delegate: NoteNewsTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        lbNote.textColor = Constants.Color.NoteTitleColor
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
        if data is ArticleObject {
            self.article = data as? ArticleObject
            if let title = self.article?.title {
                lbNote.text = title
            }
            if let poster = self.article?.poster {
                lbAuthor.text = poster
            }
            
            updateScreenMode()
        }
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: self.mainView)
        updateLabelForScreenMode(label: lbNote, colorOfNotDarkMode: Constants.Color.NoteTitleColor)
        updateLabelForScreenMode(label: lbAuthor)
        
    }
    
}
