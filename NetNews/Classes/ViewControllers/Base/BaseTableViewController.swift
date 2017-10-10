//
//  BaseTableViewController.swift
//  TableViewController
//
//  Created by Thanh Bui on 8/25/17.
//  Copyright © 2017 Thanh Bui. All rights reserved.
//

import UIKit

typealias RefreshBlock = () -> Void
typealias LoadMoreBlock = () -> Void

class BaseTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    
    var numberOfSection = 0
    var numberOfRowInSection = [Int]()
    var arrayData = [[Any]]()
    var arrayCellId = [String]()
    
    var isLoadMoreAvaible = true
    var isRefesh = false
    var isPullToRefresh = false
    var isAddLoadMore = false
    var page = 1
    var num = Constants.GetNumber.DefaultNumber
    var refreshBlock : RefreshBlock!
    var loadmoreBlock : LoadMoreBlock!
    var loadMoreStatus = false
    var refreshControl:UIRefreshControl!
    var tableViewColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
// MARK: Lazy Init
    
    
    func setupUI() {
        self.setupTableView()
    }
    
    func setupTableView() {
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.automaticallyAdjustsScrollViewInsets = false;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 40
        self.edgesForExtendedLayout = UIRectEdge.top
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        updateScreenMode()
        
        for cellId in arrayCellId {
//            tableView.register(stringClassFromString(cellId) as! UITableViewCell.Type, forCellReuseIdentifier: cellId)
            tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        }
        
        if isPullToRefresh {
            self.setupPullToRefresh()
        }
        
        if isAddLoadMore {
            self.addLoadMore()
        }
        
    }
    
    //MARK: Pull to refresh
    
    func setupPullToRefresh() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
                self?.refreshBlock()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(Constants.Color.PageMenuBackgroundColor)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }
    
    deinit {
        if tableView != nil {
            tableView.dg_removePullToRefresh()
        }
    }
    
    //MARK: Load more
    
    func addLoadMore(){
        tableView.infiniteScrollIndicatorStyle = Context.getScreenMode() ? UIActivityIndicatorViewStyle.white : UIActivityIndicatorViewStyle.gray
        tableView.addInfiniteScroll { (collectionView) -> Void in
            self.page += 1
            self.getData()
        }
        
        tableView.setShouldShowInfiniteScrollHandler { (collectionView) -> Bool in
            return self.isLoadMoreAvaible
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if isAddLoadMore && isLoadMoreAvaible {
//            let contentLarger = (scrollView.contentSize.height > scrollView.frame.size.height)
//            let viewableHeight = contentLarger ? scrollView.frame.size.height : scrollView.contentSize.height
//            let atBottom = (scrollView.contentOffset.y >= scrollView.contentSize.height - viewableHeight + 50)
//            if atBottom && !tableView.isLoadingFooterShowing() && isLoadMoreAvaible {
//                getNextPage()
//            }
//        }
//    }
//    
//    func getNextPage() {
//        tableView.showLoadingFooter()
//        self.loadmoreBlock()
//    }
    
    
    func bindDataToTableView(currentData: [[Any]]) {
        if self.tableView == nil {
            // first loading
            self.arrayData = currentData
            for list in currentData {
                self.numberOfRowInSection.append(list.count)
            }
            if currentData.count == 0 || (currentData.last?.count)! < self.num {
                self.isLoadMoreAvaible = false
            }
        } else {
            if self.page == 1 {
                // refresh
                self.arrayData.removeAll()
                self.numberOfRowInSection.removeAll()
                self.arrayData = currentData
                for list in currentData {
                    self.numberOfRowInSection.append(list.count)
                }
                self.tableView.dg_stopLoading()
                self.tableView.reloadData()
                self.isLoadMoreAvaible = true
                
            } else {
                // loadmore
                self.tableView.finishInfiniteScroll()
                
                if currentData[0].count < self.num {
                    self.isLoadMoreAvaible = false
                } else {
                    self.isLoadMoreAvaible = true
                }
                
                
                //Make array of new IndexPath
                var indexPaths = [NSIndexPath]()
                for i in 0..<currentData[0].count {
                    indexPaths.append(IndexPath.init(row: self.arrayData[self.arrayData.count - 1].count + i, section: self.arrayData.count - 1) as NSIndexPath)
                }
                
                //Add data to array
                for data in currentData[0] {
                    self.arrayData[self.arrayData.count - 1].append(data)
                }
                self.numberOfRowInSection[self.arrayData.count - 1] = (self.arrayData.last?.count)!
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths as [IndexPath], with: .fade)
                self.tableView.endUpdates()
            }
        }
    }
    
    func setupLoadMoreAndRefreshBlock() {
        self.refreshBlock = { Void in
            self.page = 1
            self.getData()
        }
        
        self.loadmoreBlock = {
            self.page += 1
            self.getData()
        }
    }
    
    func getData() {
        
    }
    
    
    
// MARK: Tableview DATASOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowInSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var baseCell : BaseTableViewCell!
        if let cell = tableView.dequeueReusableCell(withIdentifier: arrayCellId[indexPath.section]) {
            baseCell = cell as! BaseTableViewCell
        } else {
            baseCell = UINib(nibName: arrayCellId[indexPath.section], bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
        }
        let data = arrayData[indexPath.section][indexPath.row]
        baseCell.contentView.tag = indexPath.row
        baseCell.configWithData(data: data)
        return baseCell;
    }
    
// MARK: Tableview DELEGATE
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
//    func updateHeightInsetWhenPlayMusic() {
//        if tableView != nil {
//            if NetnewsRadioPlayerSwipe.shared.isShow {
//                tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
//                tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
//            } else {
//                tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
//                tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//            }
//        }
//    }

    override func updateScreenMode() {
        super.updateScreenMode()
        if tableView != nil {
            if Context.getScreenMode() {
                self.tableView.backgroundColor = UIColor.black
                tableView.infiniteScrollIndicatorStyle = UIActivityIndicatorViewStyle.white
            } else {
                self.tableView.backgroundColor = tableViewColor
                tableView.infiniteScrollIndicatorStyle = UIActivityIndicatorViewStyle.gray
            }
        }
    }
}


