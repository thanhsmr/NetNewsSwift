//
//  HomeNewsViewController.swift
//  NetNews
//
//  Created by Thanhbv on 8/31/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

protocol HomeNewsViewControllerDelegate {
    func articleTouch(article: ArticleObject)
    func listenTouch()
}

class HomeNewsViewController: BaseTableViewController, NewsTopTableViewCellDelegate, NewsDetailRelateCellDelegate, TrendingNewsTableViewCellDelegate, OverViewTableViewCellDelegate, NoteNewsTableViewCellDelegate {

    var delegate : HomeNewsViewControllerDelegate?
    var homeData = [NewsHomeObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 109), style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        self.view.addSubview(tableView)
        
        self.tableViewColor = Constants.Color.TableViewBackground
        numberOfSection = self.arrayData.count
        
        arrayCellId.append("NewsTopTableViewCell")
        arrayCellId.append("NewsDetailRelateCell")
        arrayCellId.append("OverViewTableViewCell")
        arrayCellId.append("TrendingNewsTableViewCell")
        arrayCellId.append("NoteNewsTableViewCell")
        
        
        tableView.register(UINib.init(nibName: "OverViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "OverViewHeader")
        
        
        isPullToRefresh = true;
        isAddLoadMore = false;
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
            return  NetnewsService.shared.getNewsHome()
            }.then { news -> Void in
                self.homeData = news
                var abc = [[Any]]()
                for new in news {
                    
                    if let articleData = (new as NewsHomeObject).data {
                        
                        if new.position == 3 {
                            //Data for trending
                            var dataTrending = [(Int, ArticleObject)]()
                            for i in 1...articleData.count {
                                dataTrending.append((i, articleData[i - 1]))
                            }

                            abc.append(dataTrending)
                            
                        } else if new.position == 4 {
                            //Data for Note
                            if articleData.count > 0 {
                                abc.append([articleData[0]])
                            }
                        } else {
                            abc.append(articleData)
                        }
                    }

                }
                self.bindDataToTableView(currentData: abc)
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
        
        let data = arrayData[indexPath.section][indexPath.row]
        
        switch homeData[indexPath.section].position {
            
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTopTableViewCell") {
                baseCell = cell as! NewsTopTableViewCell
                (baseCell as! NewsTopTableViewCell).delegate = self
            }
//            else {
//                baseCell = UINib(nibName: arrayCellId[indexPath.section], bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
//            }
//            (baseCell as! NewsTopTableViewCell).delegate = self
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailRelateCell") {
                baseCell = cell as! NewsDetailRelateCell
                (baseCell as! NewsDetailRelateCell).delegate = self
            }
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OverViewTableViewCell") {
                baseCell = cell as! OverViewTableViewCell
                (baseCell as! OverViewTableViewCell).delegate = self
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingNewsTableViewCell") {
                baseCell = cell as! TrendingNewsTableViewCell
                (baseCell as! TrendingNewsTableViewCell).delegate = self
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteNewsTableViewCell") {
                baseCell = cell as! NoteNewsTableViewCell
                (baseCell as! NoteNewsTableViewCell).delegate = self
            }
            
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailRelateCell") {
                baseCell = cell as! NewsDetailRelateCell
                (baseCell as! NewsDetailRelateCell).delegate = self
            }
        }
        
        baseCell.contentView.tag = indexPath.row
        baseCell.configWithData(data: data)
        return baseCell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (homeData[indexPath.section].position == 5) && (indexPath.row == (homeData[indexPath.section].data?.count)! - 1) {
            //Last row of "Tin Su Kien"
            return OverViewTableViewCell.heightCell + 5
        } else if (homeData[indexPath.section].position == 3) && (indexPath.row == (homeData[indexPath.section].data?.count)! - 1) {
            //Last row of "Tin duoc quan tam"
            return TrendingNewsTableViewCell.heightCell + 5
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if homeData[section].position == 5 || homeData[section].position == 3 {
            let overViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OverViewHeader") as! OverViewHeader
            overViewHeader.configWithTitleId(id: homeData[section].position)
            return overViewHeader
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if homeData[section].position == 5 || homeData[section].position == 3 {
            return OverViewHeader.height
        } else {
            return CGFloat.leastNormalMagnitude;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.arrayData[section].count > 0 {
            return self.homeData[section].position == 0 ? 5 : 10
        }
        return CGFloat.leastNormalMagnitude;
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func articleTouch(article: ArticleObject) {
        delegate?.articleTouch(article: article)
    }
    
    func listenTouch() {
        
    }
    
    

}
