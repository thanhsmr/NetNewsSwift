//
//  TVDetailAndRelatedViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/7/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

class TVDetailAndRelatedViewController: ContentPageViewController, VideoTableViewCellDelegate {

    var video : VideoObject?
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFakeNavigationBar(title: "", backgroundColor: UIColor.black, titleColor: UIColor.black, isBackButtonWhite: true)
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupDataTableview() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 64))
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = false;
        self.view.addSubview(tableView)
        
        numberOfSection = 1
        
        arrayCellId.append("VideoTableViewCell")
        
        self.setupUI()
        tableView.reloadData()
        playFirstVideo()
    }
    
    override func navigationBackTouch() {
        self.navigationController?.popViewController(animated: true)
        if let videoController = CacheManager.sharedManager.videoPlayerController {
            videoController.player?.pause()
            videoController.isStop = true
            videoController.view.removeFromSuperview()
            NetnewsMiniVideoPlayer.shared.hide()
        }
    }
    
    override func getData() {
        firstly {
            return  NetnewsService.shared.getTVRelated(id: (video?.id)!)
            }.then { videos -> Void in
                var totalVideo = videos
                if let video = self.video {
                    totalVideo.insert(video, at: 0)
                }
                self.bindDataToTableView(currentData: Array.init(arrayLiteral: totalVideo))
                if (self.tableView == nil) {
                    self.setupDataTableview()
                }
            }.catch { (error) in
                NSLog("%@", error.localizedDescription)
                
                if self.tableView != nil {
                    self.tableView.dg_stopLoading()
                    self.tableView.finishInfiniteScroll()
                }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let videoCell = cell as! VideoTableViewCell
        videoCell.delegate = self
        videoCell.tvTag = self.view.tag
        videoCell.configBackgroundForRelatedView()
        
        if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
            if videoPlayerController.view.tag == videoCell.contentView.tag && !videoPlayerController.isStop {
                videoPlayerController.view.alpha = 1
                videoPlayerController.view.bounds = videoCell.videoView.bounds
                videoPlayerController.view.frame.origin.x = videoCell.viewAll.frame.origin.x
                videoPlayerController.view.frame.origin.y = videoCell.viewAll.frame.origin.y
                videoCell.contentView.addSubview(videoPlayerController.view)
            } else {
                if videoPlayerController.view.tag >= 0 && !checkPlayVideoCellIsVisible() && !NetnewsMiniVideoPlayer.shared.isShow {
                    videoPlayerController.view.alpha = 0
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(tableView.indexPathsForVisibleRows?.index(of: indexPath) == nil){
            
            if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
                
            }
            
            
            
        }
        
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            playCurrentVideo(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playCurrentVideo(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        censorVideo(scrollView)
    }
    
    func censorVideo(_ scrollView: UIScrollView) {
        let visibleCells = self.tableView.visibleCells
        for cell in visibleCells {
            if let cellCurrent = getCurrentCell(scrollView) {
                if UInt(bitPattern: ObjectIdentifier(cell)) != UInt(bitPattern: ObjectIdentifier(cellCurrent)) {
                    (cell as! VideoTableViewCell).showCensor()
                }
                cellCurrent.hideCensor()
                
            }
        }
    }
    
    func getCurrentCell(_ scrollView: UIScrollView) -> VideoTableViewCell? {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset <= 0 {
            // then we are at the top
            self.lastContentOffset = scrollView.contentOffset.y;
            return self.tableView.visibleCells[0] as? VideoTableViewCell
            
        } else if scrollOffset + scrollViewHeight >= scrollContentSizeHeight - 10 {
            // then we are at the bottom
            self.lastContentOffset = scrollView.contentOffset.y;
            return self.tableView.visibleCells[self.tableView.visibleCells.count - 1] as? VideoTableViewCell
            
        } else {
            var isUp = false
            if self.lastContentOffset > scrollOffset {
                //Up
                isUp = true
            } else if self.lastContentOffset < scrollOffset {
                //Down
                isUp = false
            }
            
            self.lastContentOffset = scrollView.contentOffset.y;
            
            var indexCellPlay = -1
            if self.tableView.visibleCells.count%2 != 0 {
                indexCellPlay = (Int)(self.tableView.visibleCells.count/2)
            } else {
                indexCellPlay = (Int)((self.tableView.visibleCells.count - 1)/2) + (isUp ? 1 : 0)
            }
            if indexCellPlay >= 0 {
                return (self.tableView.visibleCells[indexCellPlay] as! VideoTableViewCell)
            }
            
        }
        return nil
    }
    
    
    func playCurrentVideo(_ scrollView: UIScrollView) {
        if let cell = getCurrentCell(scrollView) {
            cell.playInVideoRelated()
        }
    }
    
    func playFirstVideo() {
        let visibleCells = self.tableView.visibleCells
        (visibleCells[0] as! VideoTableViewCell).playInVideoRelated()
    }
    
    func playLastVideo() {
        let visibleCells = self.tableView.visibleCells
        (visibleCells[visibleCells.count - 1] as! VideoTableViewCell).playInVideoRelated()
    }
    
    
    //Mark: cell Delegate
    func btnPlayTouch(indexPlayed : Int) {
        self.tableView.scrollToRow(at: IndexPath.init(row: indexPlayed, section: 0), at: .middle, animated: true)
    }
    
    func btnDetailTouch(video: VideoObject) {
        
    }
    



}
