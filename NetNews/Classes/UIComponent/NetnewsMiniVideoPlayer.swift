//
//  NetnewsMiniVideoPlayer.swift
//  NetNews
//
//  Created by Thanhbv on 9/5/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

enum MiniVideoSwipeState : Int {
    case videoSwipeLeft
    case videoSwipeRight
    case videoSwipeNone
}


class NetnewsMiniVideoPlayer: NSObject, UIGestureRecognizerDelegate {

    var dragRecognizer : UIPanGestureRecognizer?
    var touchRecognizer : UITapGestureRecognizer?
    var playerView: UIView?
    var isAnimation = false
    var isShow = false
    var videoSwipeState = MiniVideoSwipeState.videoSwipeNone
    let animationTime = 0.3
    var tabbarHeight : CGFloat = 0
    let width =  Constants.ScreenSize.SCREEN_WIDTH/2 - 5
    var height = (Constants.ScreenSize.SCREEN_WIDTH/2 - 5)*9/16
    
    static let shared = NetnewsMiniVideoPlayer()
    
    private override init() {
        
        
    }
    
    func addGesture() {
        dragRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(move(sender:)))
        dragRecognizer?.minimumNumberOfTouches = 1
        dragRecognizer?.maximumNumberOfTouches = 1
        dragRecognizer?.delegate = self
        
        touchRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(playViewTUI(sender:)))
        touchRecognizer?.numberOfTapsRequired = 1
        touchRecognizer?.delegate = self
    }
    
    func addPlayerView() {
        playerView = UIView.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - width - 5, y: Constants.ScreenSize.SCREEN_HEIGHT - height - 5 - self.tabbarHeight , width: width, height: height))
    }
    
    func addCloseButton() {
        let closeBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        closeBtn.setImage(UIImage.init(named: "viewPlayer_btnClose"), for: .normal)
        closeBtn.addTarget(self, action: #selector(stop), for: .touchUpInside)
        playerView?.addSubview(closeBtn)
    }
    
    func show(videoView: UIView, tabbarVisible: Bool) {
        if let player = CacheManager.sharedManager.videoPlayerController.player {
            if !((player.rate != 0) && (player.error == nil)) {
                // player is not playing
                return
            }
        }
        
        NetnewsRadioPlayerSwipe.shared.hide()
    
        if tabbarVisible {
            self.tabbarHeight = 49
        }
        
        addPlayerView()
        addGesture()
        playerView?.addGestureRecognizer(dragRecognizer!)
        
        videoView.frame = CGRect.init(x: 0, y: 0, width: (playerView?.frame.size.width)!, height: (playerView?.frame.size.height)!)
        playerView?.addSubview(videoView)
        
        let touchView = UIView.init(frame: videoView.frame)
        touchView.addGestureRecognizer(touchRecognizer!)
        playerView?.addSubview(touchView)
        
        addCloseButton()
        UIApplication.shared.keyWindow?.addSubview(self.playerView!)
        isShow = true
    }
    
    
    func hide()  {
        self.playerView?.removeFromSuperview()
        isShow = false
    }
    
    func stop()  {
        if let videoController = CacheManager.sharedManager.videoPlayerController {
            videoController.player?.pause()
            videoController.isStop = true
            videoController.view.removeFromSuperview()
            NetnewsMiniVideoPlayer.shared.hide()
        }
        isShow = false
    }
    
    
    func move(sender: Any) {
        let translatedPoint = (sender as! UIPanGestureRecognizer).translation(in: self.playerView)
        if (sender as! UIPanGestureRecognizer).state == UIGestureRecognizerState.ended {
            if !isAnimation {
                updateSwipeState(translatedPoint: translatedPoint)
                updateEndingMovingFrame()
            }
        } else {
            if !isAnimation {
                updateMovingSwipeState(translatedPoint: translatedPoint)
                updateMovingFrame(translatedPoint: translatedPoint)
            }
        }
    }
    
    func playViewTUI(sender: Any) {
        if !isAnimation {
            if let videoController = CacheManager.sharedManager.videoPlayerController {
                if let video = videoController.video {
                    let tvDetail = TVDetailAndRelatedViewController()
                    tvDetail.video = video
                    tvDetail.hidesBottomBarWhenPushed = true
                    Utils.mDelegate().getRootTabbarViewController()?.navigationController?.pushViewController(tvDetail, animated: true)
                }
            }
        }
    }
    
    
    
    func updateSwipeState(translatedPoint: CGPoint) {
        self.videoSwipeState = .videoSwipeNone
        if abs(translatedPoint.x) > Constants.ScreenSize.SCREEN_WIDTH / 4
        {
            if translatedPoint.x < 0 {
                self.videoSwipeState = .videoSwipeLeft;
            } else {
                self.videoSwipeState = .videoSwipeRight;
            }
        }
        else {
            self.videoSwipeState = .videoSwipeNone;
        }
    }
    
    func updateEndingMovingFrame() {
        switch self.videoSwipeState {
        case .videoSwipeLeft, .videoSwipeRight:
           endingSwipeHorizontal()
        case .videoSwipeNone:
            endingSwipeNone()
        }
    }
    
    func endingSwipeHorizontal() {
        isAnimation = true
        
        UIView.animate(withDuration: animationTime, animations: {
            self.playerView?.alpha = 0
        }) { (finished) in
            self.stop()
//            CacheManager.sharedManager.videoPlayerController.player?.pause()
            self.isAnimation = false
            self.playerView?.frame = CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - self.width - 5, y: (self.playerView?.frame.origin.y)!, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
        }
    }
    
    func endingSwipeNone() {
        isAnimation = true
        self.playerView?.alpha = 1
        UIView.animate(withDuration: animationTime, animations: {
            self.playerView?.frame = CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - self.width - 5, y: (self.playerView?.frame.origin.y)!, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
        }) { (finished) in
            self.isAnimation = false
        }
    }
    
    func updateMovingSwipeState(translatedPoint: CGPoint) {
        if translatedPoint.x < -15 {
            self.videoSwipeState = .videoSwipeLeft
        } else if translatedPoint.x > 15 {
            self.videoSwipeState = .videoSwipeRight
        } else {
            self.videoSwipeState = .videoSwipeNone
        }
    }
    
    
    func updateMovingFrame(translatedPoint: CGPoint) {
        switch self.videoSwipeState {
        case .videoSwipeLeft, .videoSwipeRight:
            movingSwipeHorizontal(translatedPoint: translatedPoint)
        case .videoSwipeNone:
            break
        }
    }
    
    func movingSwipeHorizontal(translatedPoint: CGPoint) {
        self.playerView?.frame = CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - width - 5 + translatedPoint.x, y: (self.playerView?.frame.origin.y)!, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
        var alpha = 1 + ((translatedPoint.x / (Constants.ScreenSize.SCREEN_WIDTH / 2))) / 2;
        if self.videoSwipeState == .videoSwipeRight {
            alpha = 1 - ((translatedPoint.x / (Constants.ScreenSize.SCREEN_WIDTH / 2))) / 2;
        }
        self.playerView?.alpha = alpha
    }
    

    func updateBottomPosition() {
        let newTabbarHeight : CGFloat = Utils.mDelegate().tabbarIsHidden() ? 0 : 49
        if self.tabbarHeight == newTabbarHeight {
            return
        }
        self.tabbarHeight = newTabbarHeight
        
        isAnimation = true
        UIView.animate(withDuration: animationTime, animations: {
            self.playerView?.frame = CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - self.width - 5, y: Constants.ScreenSize.SCREEN_HEIGHT - self.height - 5 - self.tabbarHeight, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
        }) { (finished) in
            self.isAnimation = false

        }
    }

    

}
