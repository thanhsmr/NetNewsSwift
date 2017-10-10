//
//  NewsDetailCategoryViewController.swift
//  NetNews
//
//  Created by Thanhbv on 8/31/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

protocol NewsDetailCategoryViewControllerDelegate {
    func articleTouch(article: ArticleObject)
    func listenTouch()
}

class NewsDetailCategoryViewController: BaseTableViewController, NewsTopTableViewCellDelegate, NewsTableViewCellDelegate {

    var category : NewsCategory?
    var delegate : NewsDetailCategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 109))
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        self.view.addSubview(tableView)
        self.tableViewColor = Constants.Color.TableViewBackground
        numberOfSection = 1
        
        arrayCellId.append("NewsTopTableViewCell")
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
        firstly {
            return  NetnewsService.shared.getNewsByCategory(categoryId: (category?.id)!, page: page )
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
    
    override func retryLoadData() {
        setupData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var baseCell : BaseTableViewCell!
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTopTableViewCell") {
                baseCell = cell as! BaseTableViewCell
            } else {
                baseCell = UINib(nibName: arrayCellId[indexPath.section], bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
            }
            (baseCell as! NewsTopTableViewCell).delegate = self
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") {
                baseCell = cell as! BaseTableViewCell
            } else {
                baseCell = UINib(nibName: arrayCellId[indexPath.section], bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
            }
            (baseCell as! NewsTableViewCell).delegate = self
        }
        let data = arrayData[indexPath.section][indexPath.row]
        baseCell.contentView.tag = indexPath.row
        baseCell.configWithData(data: data)

        return baseCell;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
// MARK: Cell delegate
    
    func articleTouch(article: ArticleObject) {
        delegate?.articleTouch(article: article)
    }
    
    func listenTouch() {
        
    }

}
