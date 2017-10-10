//
//  FooterLoadMoreCollectionView.swift
//  NetNews
//
//  Created by Thanhbv on 9/14/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class FooterLoadMoreCollectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let loadingFooter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingFooter.frame.size.height = 50
        loadingFooter.hidesWhenStopped = true
        loadingFooter.startAnimating()
        loadingFooter.frame = CGRect.init(x: self.frame.size.width/2 - 25, y: 0, width: 50, height: 50)
        self.addSubview(loadingFooter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
