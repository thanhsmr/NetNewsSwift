
//
//  ListenButtonView.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

protocol ListenButtonViewDelegate {
    func listenButtonTouch()
}

class ListenButtonView: UIView {

    @IBOutlet weak var lbTime: UILabel!
    let nibName = "ListenButtonView"
    var view : UIView!
    var article: ArticleObject?
    
    var delegate : ListenButtonViewDelegate?

    @IBAction func listenButtonTouch(_ sender: Any) {
//        delegate?.listenButtonTouch()
        if let mediaUrl = self.article?.media_url, let article = self.article {
            if mediaUrl.length > 0 {
                NetnewsRadioPlayerSwipe.shared.show(articles: [article], tabbarVisible: !Utils.mDelegate().tabbarIsHidden())
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    
    func configWithData(article: ArticleObject)
    {
        self.article = article
        if let duration = article.duration {
            lbTime.text = duration
        }
    }
    
    func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() ->UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
