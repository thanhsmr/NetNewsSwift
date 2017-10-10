//
//  TopNowViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit
import PromiseKit

class TopNowViewController: BaseTableViewController, TopNowTableViewCellDelegate {
    
    var listSourceView: ListSourceView?
    var btnShowSource: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        addTopView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if tableView == nil {
            setupData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 109), style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        tableViewColor = Constants.Color.TableViewBackground
        self.view.addSubview(tableView)
        
        numberOfSection = 1
        num = 10
        
        arrayCellId.append("TopNowTableViewCell")
        
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
            return  NetnewsService.shared.getTopNow(page: page)
            }.then { topNowObjects -> Void in
                self.bindDataToTableView(currentData: Array.init(arrayLiteral: topNowObjects))
                if (self.tableView == nil) {
                    
                    if topNowObjects.count == 0 {
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let topNowCell = cell as! TopNowTableViewCell
        topNowCell.delegate = self
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
    
    func topNowArticleTouch(article: ArticleObject) {
        let webView = TopNowWebViewController()
        webView.article = article
        webView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    func sourceTouch(id: Int) {
        let listSourceVC = ListSourceNewsViewController()
        listSourceVC.categoryId = id
        listSourceVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(listSourceVC, animated: true)
    }
    
    func addTopView() {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: 64))
        topView.backgroundColor = Constants.Color.PageMenuBackgroundColor
        
        btnShowSource = UIButton.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - 40, y: 24, width: 40, height: 40))
        btnShowSource?.setImage(UIImage.init(named: "ic_list_source"), for: .normal)
        btnShowSource?.addTarget(self, action: #selector(showSelectSourceView), for: .touchUpInside)
        
        let lb = UILabel.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH/2 - 80, y: (btnShowSource?.frame.origin.y)! + (btnShowSource?.frame.size.height)!/2 - 11, width: 160, height: 22))
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        lb.text = "Trang nhất các báo"
        
        topView.addSubview(btnShowSource!)
        topView.addSubview(lb)
        self.view.addSubview(topView)
    }
    
    func showSelectSourceView(){
        if let _ = self.listSourceView {
            
        } else {
            self.listSourceView = ListSourceView.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 64 - 49))
            self.view.addSubview(listSourceView!)
        }
        
        self.listSourceView?.changeIsShow()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.listSourceView?.frame = CGRect.init(x: (self.listSourceView?.isShow)! ? 0 : Constants.ScreenSize.SCREEN_WIDTH, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 64 - 49)
        }) { (finish) in
            if finish {
                self.listSourceView?.dimBackground()
            }
        }
        
        if let btn = self.btnShowSource {
            btn.setImage(UIImage.init(named: (self.listSourceView?.isShow)! ? "ic_list_source_on" : "ic_list_source"), for: .normal)
        }
        
    }
    
}
