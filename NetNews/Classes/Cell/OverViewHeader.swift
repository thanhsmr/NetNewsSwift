//
//  OverViewHeader.swift
//  NetNews
//
//  Created by Thanhbv on 9/15/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

protocol OverViewHeaderDelegate {
    func headerTouch(titleId: Int)
}

class OverViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    var delegate: OverViewHeaderDelegate?
    var titleId: Int?
    
    static let height: CGFloat = 50.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreenMode), name: Notification.Name(Constants.Notification.ChangeDarkMode), object: nil)
        lbTitle.textColor = Constants.Color.OverViewHeaderTitleColor
    }
    
    @IBAction func titleTouch(_ sender: Any) {
        if let id = self.titleId {
            delegate?.headerTouch(titleId: id)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configWithTitleId(id: Int) {
        self.titleId = id
        switch id {
        case 3:
            lbTitle.text = "TIN ĐƯỢC QUAN TÂM"
        case 5:
            lbTitle.text = "TIN SỰ KIỆN"
        default:
            break
        }
        
        updateScreenMode()
    }
    
    func updateScreenMode() {
        if Context.getScreenMode() {
            lbTitle.textColor = UIColor.white
            mainView.backgroundColor = UIColor.black
            self.contentView.backgroundColor = UIColor.black

        } else {
            lbTitle.textColor = Constants.Color.OverViewHeaderTitleColor
            mainView.backgroundColor = UIColor.white
            self.contentView.backgroundColor = Constants.Color.TableViewBackground
        }

        
    }

}
