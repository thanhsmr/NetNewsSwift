//
//  TVViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class TVViewController: PageViewController, TVContentViewControllerDelegate, HomeTVViewControllerDelegate {

    override func viewDidLoad() {
        self.setupPages()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func setupPages() {
        let tvCategories = CacheManager.sharedManager.tvCategories
        if tvCategories.count > 0 {
            let homeNews = HomeTVViewController()
            let homeCategory = TVCategory()
            homeCategory.id = 0
            homeNews.tvCategory = homeCategory
            homeNews.delegate = self
            
            homeNews.view.tag = 1
            homeNews.title = "For You"
            
            self.controllerArray.append(homeNews)
            
            for i in 0..<tvCategories.count {
                let contentVC = TVContentViewController()
                contentVC.title = tvCategories[i].name
                contentVC.tvCategory = tvCategories[i]
                contentVC.delegate = self
                self.controllerArray.append(contentVC)
                
            }
            self.removeErrorScreen()
        } else {
            showErrorLoadingScreen()
        }

    }
    
    override func retryLoadData() {
        showLoadingView()
        CacheManager.sharedManager.getCategoriesData(completion: {
            self.setupPages()
            self.hideLoadingView()
        })
    }
    
    
    //MARK: CAPS Delegate
    
    override func didMoveToPage(_ controller: UIViewController, index: Int) {
        if let videoController = CacheManager.sharedManager.videoPlayerController {
            videoController.player?.pause()
            videoController.isStop = true
            videoController.view.removeFromSuperview()
            NetnewsMiniVideoPlayer.shared.hide()
        }
    }
    
    
    //MARK: VideoCell Delegate
    
    func btnDetailTouch(video: VideoObject) {
        let tvDetail = TVDetailAndRelatedViewController()
        tvDetail.video = video
        tvDetail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(tvDetail, animated: true)
    }
    
    


}
