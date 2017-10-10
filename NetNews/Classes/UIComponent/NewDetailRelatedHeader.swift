
//
//  NewDetailRelatedHeader.swift
//  NetNews
//
//  Created by Thanhbv on 9/7/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class NewDetailRelatedHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var mainView: UIView!

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = Constants.Color.TableViewBackground
        lbName.textColor = Constants.Color.OverViewHeaderTitleColor
    }
    
    func config(title: String)
    {
        lbName.text = title
        
        updateScreenMode()
    }
    
    func updateScreenMode() {
        if Context.getScreenMode() {
            lbName.textColor = UIColor.white
            self.contentView.backgroundColor = UIColor.black
            mainView.backgroundColor = UIColor.black
        } else {
            lbName.textColor = Constants.Color.OverViewHeaderTitleColor
            self.contentView.backgroundColor = Constants.Color.TableViewBackground
            mainView.backgroundColor = UIColor.white
        }
        
        
    }
}
