//
//  TVContentViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

protocol TVContentViewControllerDelegate {
    func btnDetailTouch(video: VideoObject)
}

class TVContentViewController: ContentPageViewController, VideoTableViewCellDelegate {
    
    var tvCategory : TVCategory?
    var delegate: TVContentViewControllerDelegate?

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
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 109))
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        self.view.addSubview(tableView)
        tableViewColor = UIColor.white
        numberOfSection = 1
        
        arrayCellId.append("VideoTableViewCell")
        
        isPullToRefresh = true;
        isAddLoadMore = true;
        self.setupUI()
        setupLoadMoreAndRefreshBlock()
        tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    func setupData() {
        showLoadingView()
        self.getData()
    }
    
    override func getData() {
        firstly {
            return  NetnewsService.shared.getTVByCategory(pid: 135, cid: (tvCategory?.id)!, page: page)
        }.then { videos -> Void in
            self.bindDataToTableView(currentData: Array.init(arrayLiteral: videos))
            if (self.tableView == nil) {
                
                if videos.count == 0 {
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
        let videoCell = cell as! VideoTableViewCell
        videoCell.delegate = self
        videoCell.tvTag = self.view.tag
        
        if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
            if videoPlayerController.view.tag == videoCell.contentView.tag && !videoPlayerController.isStop {
                videoPlayerController.view.alpha = 1
                videoPlayerController.view.bounds = videoCell.videoView.bounds
                videoPlayerController.view.frame.origin.x = videoCell.viewAll.frame.origin.x
                videoPlayerController.view.frame.origin.y = videoCell.viewAll.frame.origin.y
                videoCell.contentView.addSubview(videoPlayerController.view)
                NetnewsMiniVideoPlayer.shared.hide()
            } else {
                if videoPlayerController.view.tag >= 0 && !checkPlayVideoCellIsVisible() && !NetnewsMiniVideoPlayer.shared.isShow {
                    videoPlayerController.view.alpha = 0
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(tableView.indexPathsForVisibleRows?.index(of: indexPath) == nil){
            
            if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
                
                if videoPlayerController.view.tag == cell.contentView.tag {
                    //video playing cell
//                    let videoCell = cell as! VideoTableViewCell
                    NetnewsMiniVideoPlayer.shared.show(videoView: videoPlayerController.view, tabbarVisible: true)
                }
            }
            


        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func btnPlayTouch(indexPlayed : Int) {
    }
    
    func checkPlayVideoCellIsVisible() -> Bool {
        if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
            let cellVisibles = tableView.visibleCells as! [VideoTableViewCell]
            for cell in cellVisibles {
                if videoPlayerController.view.tag == cell.contentView.tag {
                    return true
                }
            }
            return false
        }
        return false
    }
    
    func btnDetailTouch(video: VideoObject) {
        delegate?.btnDetailTouch(video: video)
    }
    


}
