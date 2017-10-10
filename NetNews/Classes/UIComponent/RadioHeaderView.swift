//
//  RadioHeaderView.swift
//  NetNews
//
//  Created by Thanhbv on 9/13/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class RadioHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lbName: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = Constants.Color.TableViewBackground
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func config(title: String)
    {
        lbName.text = title.isToDayString()
    }
}
