//
//  CacheManager.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper
import AVKit
import KDEAudioPlayer



enum VideoPlayerControllerFromKey: Int {
    case fromTV
    case fromNewsDetail
}



class CacheManager {
    
    var newsCategories = [NewsCategory]()
    var tvCategories = [TVCategory]()
    var radioCategories = [RadioCategory]()
    var sources = [SourceObject]()
    var videoPlayerController: NetnewsAVPlayer!
    var radioPlayerController: AudioPlayer!
    
    class var sharedManager: CacheManager {
        get {
            struct Singleton {
                static let instance = CacheManager()
            }
            return Singleton.instance
        }
    }
    
    //private init
    private init() {
        self.videoPlayerController = NetnewsAVPlayer()
        videoPlayerController.view.tag = -1
        self.radioPlayerController = AudioPlayer()
        
    }
    
    func clearAllCaches() {

    }
    
    
    func getCategoriesData(completion: @escaping () -> ()) {
        firstly {
            when(fulfilled: NetnewsService.shared.getCategoryNew(), NetnewsService.shared.getCategoryTV(), NetnewsService.shared.getCategoryRadio() , NetnewsService.shared.getListSource()) 
            }.then { newsCategories, tvCategories, radioCategories, sources -> Void in
                CacheManager.sharedManager.newsCategories = newsCategories
                CacheManager.sharedManager.tvCategories = tvCategories
                CacheManager.sharedManager.radioCategories = radioCategories
                CacheManager.sharedManager.sources = sources
            }.always {
                completion()
            }.catch { error in
                Log.debug("Error: \(error)")
        }
    }
    
    
}

