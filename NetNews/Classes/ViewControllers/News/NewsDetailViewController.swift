//
//  NewsDetailViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

class NewsDetailViewController: BaseTableViewController, NewsDetailRelateCellDelegate {

    var article : ArticleObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFakeNavigationBar(title: "", backgroundColor: UIColor.lightGray, titleColor: UIColor.black, isBackButtonWhite: false)
        self.setupData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navigationBackTouch() {
        self.navigationController?.popViewController(animated: true)
        pauseVideoPlayer()
    }
    


    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 64), style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        tableView.estimatedRowHeight = 200;
        tableViewColor = Constants.Color.TableViewBackground
        self.view.addSubview(tableView)
        
        numberOfSection = 4
        
        arrayCellId.append("NewsTextTableViewCell")
        arrayCellId.append("NewsVideoTableViewCell")
        arrayCellId.append("NewsPictureTableViewCell")
        arrayCellId.append("NewAuthorTableViewCell")
        arrayCellId.append("TopNewsDetailTableViewCell")
        arrayCellId.append("NewsDetailRelateCell")
        arrayCellId.append("NewsNoDataCell")
        
        tableView.register(UINib.init(nibName: "NewDetailRelatedHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "NewDetailRelatedHeader")
        
        self.setupUI()
        self.tableView.reloadData()
    }
    
    func setupData() {
        if let article = self.article {

            // make 3 frist body
            if let threeFristBody = article.bodies {
                let bodyObjects = threeFristBody
                self.bindDataToTableView(currentData: [[article], bodyObjects, [], []])
            } else {
                self.bindDataToTableView(currentData: [[article], [], [], []])
            }
            
            self.setupDataTableview()
            
            //Get full data
            getData()
        }
        
        
    }
    
    override func getData() {
        if self.article?.pid == 0 && self.article?.cid == 0 {
            numberOfSection = 2
            let noteString = "Đang cập nhật dữ liệu..."
            self.arrayData[1].append(noteString)
            self.numberOfRowInSection[1] = 1
            tableView.backgroundColor = UIColor.white
            if (self.tableView != nil) {
                self.tableView.reloadData()
            }
            return
        }
        
        //Make array of new IndexPath
        var indexPaths = [NSIndexPath]()
        
        firstly {
            return  NetnewsService.shared.getNewsContent(pid: (self.article?.pid)!, cid: (self.article?.cid)!, sId: (self.article?.id)!)
            }.then { (bodyObjects) -> Void in
                if bodyObjects.count > self.arrayData[1].count {
                    
                    for i in (self.arrayData[1].count > 0 ? self.arrayData[1].count : 0)..<bodyObjects.count {
                        self.arrayData[1].append(bodyObjects[i])
                        //Add Index to insert
                        indexPaths.append(IndexPath.init(row: i, section: 1) as NSIndexPath)
                    }

                    self.numberOfRowInSection[1] = self.arrayData[1].count
                }
            }.then { Void -> Promise<[ArticleObject]> in
                return NetnewsService.shared.getNewsRelated(pid: (self.article?.pid)!, cid: (self.article?.cid)!, sId: (self.article?.id)!)
            }
            //Nếu thêm chuyên mục toàn cảnh thì uncomment ở đây
//            .then { articles -> Void in
//                for article in articles {
//                    self.arrayData[self.arrayData.count - 2].append(article)
//                }
//                self.numberOfRowInSection[self.numberOfRowInSection.count - 2] = articles.count
//            }.then { Void -> Promise<[ArticleObject]> in
//                return NetnewsService.shared.getNewsRelated(pid: (self.article?.pid)!, cid: (self.article?.cid)!, sId: (self.article?.id)!)
//            }
            .then { articles -> Void in
                for article in articles {
                    self.arrayData[self.arrayData.count - 1].append(article)
                }
                self.numberOfRowInSection[self.numberOfRowInSection.count - 1] = articles.count
            }.always {
                // Update tableview
                self.tableView.reloadData()
            }.catch { (error) in
                NSLog("%@", error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var baseCell : BaseTableViewCell!
        
        let data = arrayData[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopNewsDetailTableViewCell") {
                baseCell = cell as! BaseTableViewCell
            } else {
                baseCell = UINib(nibName: "TopNewsDetailTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
            }
        } else if indexPath.section == 1 {
            
            if data is BodyDetailArticle {
                switch (data as! BodyDetailArticle).type {
                case 1:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextTableViewCell") {
                        baseCell = cell as! BaseTableViewCell
                    } else {
                        baseCell = UINib(nibName: "NewsTextTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
                    }
                case 2:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPictureTableViewCell") {
                        baseCell = cell as! BaseTableViewCell
                    } else {
                        baseCell = UINib(nibName: "NewsPictureTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
                    }
                case 3:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsVideoTableViewCell") {
                        baseCell = cell as! BaseTableViewCell
                    } else {
                        baseCell = UINib(nibName: "NewsVideoTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
                    }
                case 4:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "NewAuthorTableViewCell") {
                        baseCell = cell as! BaseTableViewCell
                    } else {
                        baseCell = UINib(nibName: "NewAuthorTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
                    }
                    
                default:
                    break
                }
            } else {
                if data is String {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsNoDataCell") {
                        baseCell = cell as! BaseTableViewCell
                    } else {
                        baseCell = UINib(nibName: "NewsNoDataCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
                    }
                }
            }


        } else if indexPath.section == 2 || indexPath.section == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailRelateCell") {
                baseCell = cell as! BaseTableViewCell
            } else {
                baseCell = UINib(nibName: "NewsDetailRelateCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseTableViewCell
            }
            (baseCell as! NewsDetailRelateCell).delegate = self
        }
        baseCell.contentView.tag = indexPath.row
        baseCell.configWithData(data: data)
        return baseCell;
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && arrayData[indexPath.section][indexPath.row] is BodyDetailArticle && ((arrayData[indexPath.section][indexPath.row] as! BodyDetailArticle).type == 3) {
            if cell is NewsVideoTableViewCell {
                let videoCell = cell as! NewsVideoTableViewCell
                
                if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
                    if videoPlayerController.view.tag == videoCell.contentView.tag && !videoPlayerController.isStop {
                        videoPlayerController.view.alpha = 1
                        videoPlayerController.view.frame = videoCell.imageMain.frame
                        videoCell.contentView.addSubview(videoPlayerController.view)
                        NetnewsMiniVideoPlayer.shared.hide()
                    } else {
                        if videoPlayerController.view.tag >= 0 && !checkPlayVideoCellIsVisible() && !NetnewsMiniVideoPlayer.shared.isShow {
                            videoPlayerController.view.alpha = 0
                        }
                    }
                }
            }
        }


    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = arrayData[indexPath.section][indexPath.row]
        
        if indexPath.section == 1 {
            if data is BodyDetailArticle  {
                let bodyDetailArticle = (data as! BodyDetailArticle)
                switch bodyDetailArticle.type {
                case 1:
                    return UITableViewAutomaticDimension;
                case 2:
                    if bodyDetailArticle.width == 0 || bodyDetailArticle.height == 0 {
                        return CGFloat.leastNormalMagnitude;
                    }
                    
                    let height = ((Constants.ScreenSize.SCREEN_WIDTH) / CGFloat(bodyDetailArticle.width)) * CGFloat(bodyDetailArticle.height) + 10;
                    if (height > 0) {
                        return height;
                    }
                    
                    return CGFloat.leastNormalMagnitude;
                case 3:
                    return (Constants.ScreenSize.SCREEN_WIDTH)*9/16 + 10;
                case 4:
                    return UITableViewAutomaticDimension;
                default:
                    break
                }
            } else {
                return UITableViewAutomaticDimension;
            }

        }
       return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 && self.arrayData[self.arrayData.count - 2].count > 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewDetailRelatedHeader") as! NewDetailRelatedHeader
            header.config(title: String.init(format: "TOÀN CẢNH: %@", "ABC"))
            return header
        } else if section == 3 && self.arrayData[self.arrayData.count - 1].count > 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewDetailRelatedHeader") as! NewDetailRelatedHeader
            header.config(title: "TIN CÙNG CHUYÊN MỤC")
            return header
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 2 && self.arrayData[self.arrayData.count - 2].count > 0) || (section == 3 && self.arrayData[self.arrayData.count - 1].count > 0) {
            return 65
        }
        return CGFloat.leastNormalMagnitude;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude;
    }
    
    func pauseVideoPlayer() {
        if let videoController = CacheManager.sharedManager.videoPlayerController {
            if videoController.videoPlayerControllerFrom == .fromNewsDetail {
                videoController.player?.pause()
                videoController.isStop = true
            }
        }
    }
    
    func checkPlayVideoCellIsVisible() -> Bool {
        if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
            let cellVisibles = tableView.visibleCells
            for cell in cellVisibles {
                if cell is NewsVideoTableViewCell && videoPlayerController.view.tag == cell.contentView.tag {
                    return true
                }
            }
            return false
        }
        return false
    }
    
    
    //MARK: cell delegate
    func articleTouch(article: ArticleObject) {
        let newsVC = NewsDetailViewController()
        newsVC.article = article
        self.navigationController?.pushViewController(newsVC, animated: true)
        pauseVideoPlayer()
    }

}
