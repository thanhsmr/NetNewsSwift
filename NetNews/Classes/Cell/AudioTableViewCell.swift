//
//  AudioTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary

protocol AudioTableViewCellDelegate {
    func touchRadio(article : ArticleObject?)
}

class AudioTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbViewCount: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lbName: RadioTitleLabel!
    var delegate : AudioTableViewCellDelegate?
    var article : ArticleObject?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = Constants.Color.TableViewBackground
        lbTime.textColor = Constants.Color.RadioTimeColor
        lbViewCount.textColor = Constants.Color.RadioViewColor
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
            if let imageUrl = data.image {
                imgMain.setImage(url: URL.init(string: imageUrl), placeholder: UIImage.init(named: "video_place_holder"))
            } else {
                imgMain.image = UIImage.init(named: "video_place_holder")
            }
            lbName.text = data.title
            lbTime.text = data.date
            
            lbViewCount.text = (data.read_count?.formatUsingAbbrevation())! + " views"
            
            updateScreenMode()
        }
    }
    
    @IBAction func touchRadio(_ sender: Any) {
        delegate?.touchRadio(article: self.article)
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbName)
        updateLabelForScreenMode(label: lbTime, colorOfNotDarkMode: Constants.Color.RadioTimeColor)
        updateLabelForScreenMode(label: lbViewCount, colorOfNotDarkMode: Constants.Color.RadioViewColor)
        updateViewForScreenMode(view: self.contentView, colorOfNotDarkMode: Constants.Color.TableViewBackground)
        updateViewForScreenMode(view: mainView)
    }
}
