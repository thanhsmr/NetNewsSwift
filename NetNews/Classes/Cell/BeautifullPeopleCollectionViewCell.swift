//
//  BeautifullPeopleCollectionViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/14/17.
//  Copyright © 2017 Viettel Media. All rights reserved.


import UIKit
import Imaginary

protocol BeautifullPeopleCollectionViewCellDelegate {
    func articleTouch(article: ArticleObject)
}

class BeautifullPeopleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbTitle: BeutifullPeopleTitleLabel!
    var delegate: BeautifullPeopleCollectionViewCellDelegate?
    var article: ArticleObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configWithData(article: ArticleObject) {
        self.article = article
        imageMain.setImage(url: URL.init(string: article.image169!), placeholder: UIImage.init(named: "video_place_holder"))
        lbTitle.text = article.title
    }

    @IBAction func touchArticle(_ sender: Any) {
        if let article = self.article {
            delegate?.articleTouch(article: article)
        }
    }
    
}
