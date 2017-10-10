//
//  BaseTableViewCell.swift
//  TableViewController
//
//  Created by Thanh Bui on 8/25/17.
//  Copyright © 2017 Thanh Bui. All rights reserved.
//

import UIKit

protocol BaseTableViewCellDelegate {
    
}

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreenMode), name: Notification.Name(Constants.Notification.ChangeDarkMode), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreenMode), name: Notification.Name(Constants.Notification.ChangeDarkMode), object: nil)
        // Configure the view for the selected state
    }
    
    func configWithData(data: Any) {
        
    }
    
    func updateScreenMode() {
    }
    
    func updateLabelForScreenMode(label: UILabel! , colorOfNotDarkMode: UIColor? = nil) {
        if Context.getScreenMode() {
            label.textColor = UIColor.white
        } else {
            label.textColor = (colorOfNotDarkMode == nil) ? UIColor.black : colorOfNotDarkMode
        }
    }
    
    func updateViewForScreenMode(view: UIView!, colorOfNotDarkMode: UIColor? = nil) {
        if Context.getScreenMode() {
            view.backgroundColor = UIColor.black
        } else {
            view.backgroundColor = (colorOfNotDarkMode == nil) ? UIColor.white : colorOfNotDarkMode
        }
    }

}
