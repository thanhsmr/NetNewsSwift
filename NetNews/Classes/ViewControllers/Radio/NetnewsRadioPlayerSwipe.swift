//
//  NetnewsRadioPlayerSwipe.swift
//  NetNews
//
//  Created by Thanhbv on 9/11/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

enum MiniRadioPlayerSwipeState : Int {
    case musicSwipeLeft
    case musicSwipeRight
    case musicSwipeNone
}

class NetnewsRadioPlayerSwipe: NSObject, UIGestureRecognizerDelegate, RadioPlayerViewDelegate {
    
    var dragRecognizer : UIPanGestureRecognizer?
    var touchRecognizer : UITapGestureRecognizer?
    var playerView: RadioPlayerView?
    var isAnimation = false
    var isShow = false
    var videoSwipeState = MiniVideoSwipeState.videoSwipeNone
    let animationTime = 0.3
    var tabbarHeight : CGFloat = 0
    let width =  Constants.ScreenSize.SCREEN_WIDTH
    let height: CGFloat = 50;
    
    static let shared = NetnewsRadioPlayerSwipe()
    
    private override init() {
        
        
    }
    
    func addGesture() {
        dragRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(move(sender:)))
        dragRecognizer?.minimumNumberOfTouches = 1
        dragRecognizer?.maximumNumberOfTouches = 1
        dragRecognizer?.delegate = self
    }
    
    func addPlayerView() {
        playerView = RadioPlayerView.fromNib(nibNameOrNil: "RadioPlayerView") as? RadioPlayerView
        playerView?.frame = CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH, y: Constants.ScreenSize.SCREEN_HEIGHT - self.height - self.tabbarHeight, width: width, height: height)
        playerView?.delegate = self
    }
    
    func show(articles: [ArticleObject], tabbarVisible: Bool) {
        let time0 = Date()
        NetnewsMiniVideoPlayer.shared.hide()
        hide()
        let time1 = Date()
        if tabbarVisible {
            self.tabbarHeight = 49
        } else {
            self.tabbarHeight = 0
        }
        
        let time2 = Date()
        addPlayerView()
        
        UIApplication.shared.keyWindow?.addSubview(self.playerView!)
        let time3 = Date()
        self.isAnimation = true
        UIView.animate(withDuration: animationTime, animations: {
            self.playerView?.frame = CGRect.init(x: 0, y: Constants.ScreenSize.SCREEN_HEIGHT - self.height - self.tabbarHeight , width: self.width, height: self.height)
        }) { (finished) in
            self.isAnimation = false
        }
        let time4 = Date()
        
        DispatchQueue.global().async {
            self.playerView?.setData(arrArticle: articles)
        }
        
        addGesture()
        playerView?.miniPlayerView.addGestureRecognizer(dragRecognizer!)
        isShow = true
        let time5 = Date()
        
        NSLog("Time Action -------- 1 %f", time1.timeIntervalSince(time0))
        NSLog("Time Action -------- 2 %f", time2.timeIntervalSince(time0))
        NSLog("Time Action -------- 3 %f", time3.timeIntervalSince(time0))
        NSLog("Time Action -------- 4 %f", time4.timeIntervalSince(time0))
        NSLog("Time Action -------- 5 %f", time5.timeIntervalSince(time0))


    }
    
    
    func hide()  {
        stop()
        isShow = false
        if let player = self.playerView {
            player.removeFromSuperview()
        }
    }
    
    func stop()  {
        if let player = self.playerView {
            player.stop()
        }
    }
    
    func showQueue(isShow : Bool) {
        if isShow {
            self.playerView?.frame = CGRect.init(x: 0, y: 0, width: (self.playerView?.frame.size.width)!, height: Constants.ScreenSize.SCREEN_HEIGHT - self.tabbarHeight)
        } else {
            self.playerView?.frame = CGRect.init(x: 0, y: Constants.ScreenSize.SCREEN_HEIGHT - self.height - self.tabbarHeight , width: self.width, height: self.height)
        }
        
    }
    
    func move(sender: Any) {
        
        if let player = self.playerView {
            if player.isShowQueue {
                return
            }
        }
        
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
            self.isAnimation = false
            self.playerView?.frame = CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH - self.width - 5, y: (self.playerView?.frame.origin.y)!, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
        }
    }
    
    func endingSwipeNone() {
        isAnimation = true
        self.playerView?.alpha = 1
        UIView.animate(withDuration: animationTime, animations: {
            self.playerView?.frame = CGRect.init(x: 0, y: Constants.ScreenSize.SCREEN_HEIGHT - self.height - self.tabbarHeight , width: self.width, height: self.height)
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
        self.playerView?.frame = CGRect.init(x: 0 + translatedPoint.x, y: (self.playerView?.frame.origin.y)!, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
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
            self.playerView?.frame = CGRect.init(x: 0, y: Constants.ScreenSize.SCREEN_HEIGHT - self.height - self.tabbarHeight, width: (self.playerView?.frame.size.width)!, height: (self.playerView?.frame.size.height)!)
        }) { (finished) in
            self.isAnimation = false
            
        }
    }
    
}
