//
//  MoreTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class MoreTableViewCell: BaseTableViewCell {

    @IBOutlet weak var moreImage: UIImageView!
    @IBOutlet weak var lbName: MoreDetailLabel!
    @IBOutlet weak var switchControl: UISwitch!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func configWithData(data: Any) {
        if data is MoreObject {
            lbName.text = (data as! MoreObject).name
            moreImage.image = UIImage.init(named: (data as! MoreObject).image)
            
            if (data as! MoreObject).type == moreType.darkMode {
                switchControl.isHidden = false
                switchControl.isOn = Context.getScreenMode()
            }
            
            updateScreenMode()
        }
    }

    @IBAction func switchChange(_ sender: Any) {
        Context.saveScreenMode(switchControl.isOn)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.ChangeDarkMode), object: nil)
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbName)
        updateViewForScreenMode(view: self.contentView)
    }
    
    
}

