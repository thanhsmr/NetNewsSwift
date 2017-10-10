//
//  RadioHeaderTableView.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

protocol RadioHeaderTableViewDelegate {
    func listenButtonTouch()
}

class RadioHeaderTableView: UIView, ListenButtonViewDelegate {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var listenButtonView: ListenButtonView!
    var delegate : RadioHeaderTableViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        listenButtonView.delegate = self
    }

    func configWithData(){
        
    }
    
    func listenButtonTouch() {
        self.delegate?.listenButtonTouch()
    }
}
