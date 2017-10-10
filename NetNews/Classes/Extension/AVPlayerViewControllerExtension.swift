//
//  AVPlayerViewControllerExtension.swift
//  NetNews
//
//  Created by Thanhbv on 9/7/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension AVPlayerViewController {
    struct VideoPlayerControllerKey {
        static var fromKey = "FromKey"
        static var categoryKey = "TVTag"
        static var isStop = "IsStop"
    }
    
    
    var videoPlayerControllerFrom: VideoPlayerControllerFromKey {
        get {
            if let indexPath = objc_getAssociatedObject(self, &VideoPlayerControllerKey.fromKey) as? VideoPlayerControllerFromKey {
                return indexPath
            }
            
            return .fromTV
        }
        set {
            objc_setAssociatedObject(self, &VideoPlayerControllerKey.fromKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var tvTag: Int {
        get {
            if let indexPath = objc_getAssociatedObject(self, &VideoPlayerControllerKey.categoryKey) as? Int {
                return indexPath
            }
            
            return 0
        }
        set {
            objc_setAssociatedObject(self, &VideoPlayerControllerKey.categoryKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var isStop: Bool {
        get {
            if let indexPath = objc_getAssociatedObject(self, &VideoPlayerControllerKey.categoryKey) as? Bool {
                return indexPath
            }
            
            return false
        }
        set {
            objc_setAssociatedObject(self, &VideoPlayerControllerKey.categoryKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

}
