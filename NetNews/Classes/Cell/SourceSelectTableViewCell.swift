//
//  SourceSelectTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/18/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class SourceSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var lbSourceName: UILabel!
    @IBOutlet weak var switchSource: UISwitch!
    var source : SourceObject?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithData(currentSource: SourceObject) {
        self.source = currentSource
        self.lbSourceName.text = currentSource.name
    }
    
    func configSwitch() {

    }
    
}
