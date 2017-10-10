//
//  ListSourceView.swift
//  NetNews
//
//  Created by Thanhbv on 9/18/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class ListSourceView: UIView{
    var tableView : UITableView?
    var arrSource = [SourceObject]()
    var isShow = false

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.addTableView()
        getData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeIsShow(){
        self.isShow = !(self.isShow)
    }
    
    func dimBackground() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: self.isShow ? 0.5 : 0.0)
        }
    }
    
    func addTableView() {
        tableView = UITableView.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - 250, y: 0, width: 250, height: self.frame.size.height))
        tableView?.backgroundColor = UIColor.white
        tableView?.allowsSelection = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.register(UINib.init(nibName: "SourceSelectTableViewCell", bundle: nil), forCellReuseIdentifier: "SourceSelectTableViewCell")
        
        self.addSubview(tableView!)
    }
    
    func getData() {
        arrSource = CacheManager.sharedManager.sources
        tableView?.reloadData()
    }

}

extension ListSourceView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceSelectTableViewCell") as! SourceSelectTableViewCell
        cell.configWithData(currentSource: arrSource[indexPath.row])
        return cell
    }
}

extension ListSourceView : UITableViewDelegate {
    
}
