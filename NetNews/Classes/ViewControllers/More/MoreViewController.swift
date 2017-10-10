//
//  MoreViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class MoreViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addFakeStatusBarLight()
        setupDataTableview()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Context.getScreenMode() ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default
    }
    

    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 20, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 20))
        tableView.delegate = self;
        tableView.dataSource = self;
        tableViewColor = UIColor.white
        self.view.addSubview(tableView)
        
        numberOfSection = 1
        
        let detailArrayData = MoreObject.getListMoreObject()
        numberOfRowInSection.append(detailArrayData.count)
        
        arrayData.append(detailArrayData)
        
        arrayCellId.append("MoreTableViewCell")
        
        isPullToRefresh = false;
        self.setupUI()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        self.setNeedsStatusBarAppearanceUpdate()
    }

}
