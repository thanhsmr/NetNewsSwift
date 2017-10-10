//
//  RadioContentViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

protocol RadioContentViewControllerDelegate {
    func touchRadio(articles: [ArticleObject]?)
}

class RadioContentViewController: ContentPageViewController, AudioTableViewCellDelegate {

    var category : RadioCategory?
    var delegate : RadioContentViewControllerDelegate?
    
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
        tableViewColor = Constants.Color.TableViewBackground
        self.view.addSubview(tableView)
        
        numberOfSection = 1
        
        arrayCellId.append("AudioTableViewCell")
        
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
            return  NetnewsService.shared.getRadioByCategory(categoryId: (category?.id)!, page: page )
            }.then { radios -> Void in
                self.bindDataToTableView(currentData: Array.init(arrayLiteral: radios))
                if (self.tableView == nil) {
                    
                    if radios.count == 0 {
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
                
                if (self.tableView != nil) {
                    self.tableView.dg_stopLoading()
                    self.tableView.finishInfiniteScroll()
                }
        }
    }
    
    override func retryLoadData() {
        setupData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! AudioTableViewCell
        cell.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //MARK: cell Delegate
    
    func touchRadio(article: ArticleObject?) {

        var i = 0
        var articlesToPlay = [ArticleObject]()
        for currentArticle in self.arrayData[0] {
            if (currentArticle as! ArticleObject).id == article?.id {
                i += 1
            }
            if i >= 1 && articlesToPlay.count <= 20 {
                articlesToPlay.append(currentArticle as! ArticleObject)
            }
        }
        
        delegate?.touchRadio(articles: articlesToPlay)
    }
    


}
