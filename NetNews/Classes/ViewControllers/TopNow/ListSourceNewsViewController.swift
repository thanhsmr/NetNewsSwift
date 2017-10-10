//
//  ListSourceNewsViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/12/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

class ListSourceNewsViewController: BaseTableViewController, NewsTableViewCellDelegate {
    
    var categoryId : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        addFakeNavigationBar(title: "", backgroundColor: UIColor.gray, titleColor: UIColor.white, isBackButtonWhite: true)
        setupData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navigationBackTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    

    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 64))
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        tableViewColor = Constants.Color.TableViewBackground
        self.view.addSubview(tableView)
        
        numberOfSection = 1
        
        arrayCellId.append("NewsTableViewCell")
        
        isPullToRefresh = true;
        isAddLoadMore = true;
        self.setupUI()
        setupLoadMoreAndRefreshBlock()
        tableView.reloadData()
    }
    
    func setupData() {
        showLoadingView()
        self.getData()
    }
    
    override func getData() {
        if let id = categoryId {
            firstly {
                return  NetnewsService.shared.getListSourceNews(categoryId: id, page: page)
                }.then { news -> Void in
                    self.bindDataToTableView(currentData: Array.init(arrayLiteral: news))
                    if (self.tableView == nil) {
                        
                        if news.count == 0 {
                            self.showEmtyScreen()
                        } else {
                            self.setupDataTableview()
                        }
                        
                    }
                    
                }.always {
                    self.hideLoadingView()
                }.catch { (error) in
                    NSLog("%@", error.localizedDescription)
                    
                    if self.arrayData.count == 0 {
                        self.showErrorLoadingScreen()
                    }
                    
                    if self.tableView != nil {
                        self.tableView.dg_stopLoading()
                        self.tableView.finishInfiniteScroll()
                    }
            }
        }
        

    }
    
    override func retryLoadData() {
        setupData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let newCell = cell as! NewsTableViewCell
        newCell.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func articleTouch(article: ArticleObject) {
        let newsDetailVC = NewsDetailViewController()
        newsDetailVC.article = article
        newsDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    
    func listenTouch() {
        
    }


}
