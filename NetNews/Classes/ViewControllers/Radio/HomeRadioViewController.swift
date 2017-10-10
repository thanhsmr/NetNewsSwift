//
//  HomeRadioViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

protocol HomeRadioViewControllerDelegate {
    func touchRadio(articles: [ArticleObject]?)
}

class HomeRadioViewController: BaseTableViewController, AudioTableViewCellDelegate {

    var delegate : RadioContentViewControllerDelegate?
    var sections = Dictionary<String, Array<ArticleObject>>()
    var sortedSections = [String]()
    
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
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 109), style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        tableViewColor = Constants.Color.TableViewBackground
        self.view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "AudioTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioTableViewCell")
        tableView.register(UINib.init(nibName: "RadioHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RadioHeaderView")
        
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
            return  NetnewsService.shared.getRadioByCategory(categoryId: 0, page: page )
            }.then { radios -> Void in
                self.bindDataToTableView(radios: radios)
                if (self.tableView == nil) {
                    if radios.count == 0 {
                        self.showEmtyScreen()
                    } else {
                        self.setupDataTableview()
                    }
                } else {
                    self.tableView.reloadData()
                }
                
            }.always {
                self.hideLoadingView()
            }.catch { (error) in
                NSLog("%@", error.localizedDescription)
                
                if self.sections.count == 0 {
                    self.showErrorLoadingScreen()
                }
                
                if (self.tableView != nil) {
                    self.tableView.dg_stopLoading()
                    self.tableView.finishInfiniteScroll()
                }
        }
    }
    
    func configRadioData(radios: [ArticleObject]) {
        
        for article in radios {
            let articleDate = Date.init(timeIntervalSince1970: article.timeStamp!)
            
            let creationDate = articleDate.toString(format: "dd-MM-yyyy")
            
            //If there's no section in dictionary for this creationDate, create new one
            if self.sections.index(forKey: creationDate) == nil {
                self.sections[creationDate] = [article]
            }
            else {
                self.sections[creationDate]!.append(article)
            }
        }
        self.sortedSections = Array(self.sections.keys).sorted(by: >)
    }
    
    func bindDataToTableView(radios: [ArticleObject]) {
        if self.tableView == nil {
            // first loading
            if (radios.count) < self.num {
                self.isLoadMoreAvaible = false
            }
            configRadioData(radios: radios)
        } else {
            if self.page == 1 {
                // refresh
                self.sections.removeAll()
                self.sortedSections.removeAll()
                configRadioData(radios: radios)

                self.tableView.dg_stopLoading()
                self.isLoadMoreAvaible = true
                
            } else {
                // loadmore
                configRadioData(radios: radios)

                self.tableView.finishInfiniteScroll()
                
                if radios.count < self.num {
                    self.isLoadMoreAvaible = false
                } else {
                    self.isLoadMoreAvaible = true
                }
            }
        }
    }
    
    override func retryLoadData() {
        setupData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sortedSections[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var baseCell : BaseTableViewCell!
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AudioTableViewCell") {
            baseCell = cell as! AudioTableViewCell
        } else {
            baseCell = UINib(nibName: "AudioTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AudioTableViewCell
        }
        (baseCell as! AudioTableViewCell).delegate = self
        
        let tableSection = sections[sortedSections[indexPath.section]]
        let tableItem = tableSection![indexPath.row]
        
        baseCell.configWithData(data: tableItem)
        return baseCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RadioHeaderView") as! RadioHeaderView
        header.config(title: sortedSections[section])
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! AudioTableViewCell
        cell.delegate = self
    }
    
    //MARK: cell Delegate
    
    func touchRadio(article: ArticleObject?) {
        
        var i = 0
        var articlesToPlay = [ArticleObject]()
        let arraySection = Array(sections.values)
        
        for section in arraySection {
            if i == 0 {
                for currentArticle in section {
                    if currentArticle.id == article?.id {
                        i += 1
                    }
                    if i >= 1 && articlesToPlay.count <= 20 {
                        articlesToPlay.append(currentArticle)
                    }
                }
            } else {
                break
            }
        }
        
        delegate?.touchRadio(articles: articlesToPlay)
    }

}
