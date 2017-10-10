//
//  NetnewsService.swift
//  NetNews
//
//  Created by Thanhbv on 8/31/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import PromiseKit

class NetnewsService: NSObject {
    
    // Can't init is singleton
    private override init()
    {
        
    }
    
    // MARK: Shared Instance
    static let shared = NetnewsService()
    
    public func getCategoryNew() -> Promise<[NewsCategory]>
    {
        return Promise { fulfill, reject in
            ServiceFactory.get(url: Constants.API.URL_GET_CATEGORY_NEWS) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                            [
                                NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let newCategories = Mapper<NewsCategory>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(newCategories)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }

    }
    
    public func getCategoryTV() -> Promise<[TVCategory]>
    {
        return Promise { fulfill, reject in
            ServiceFactory.get(url: Constants.API.URL_GET_CATEGORY_TV) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let tvCategories = Mapper<TVCategory>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(tvCategories)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    
    public func getTVByCategory(pid: Int, cid: Int, page : Int) -> Promise<[VideoObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d/%d", Constants.API.URL_GET_VIDEO_TV_BY_CATEGORY ,pid ,cid ,page)
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let tvCategories = Mapper<VideoObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(tvCategories)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    
    public func getTVRelated(id: Int) -> Promise<[VideoObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d", Constants.API.URL_GET_TV_RELATED ,id)
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let tvCategories = Mapper<VideoObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(tvCategories)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    public func getCategoryRadio() -> Promise<[RadioCategory]>
    {
        return Promise { fulfill, reject in
            ServiceFactory.get(url: Constants.API.URL_GET_CATEGORY_RADIO) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let radioCategories = Mapper<RadioCategory>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(radioCategories)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    public func getVideo(page: Int, num : Int? = nil) -> Promise<[VideoObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d", Constants.API.URL_GET_VIDEO_TV,page,(num == nil ? Constants.GetNumber.DefaultNumber : num!))
            
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let videos = Mapper<VideoObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(videos)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    
    public func getNewsByCategory(categoryId: Int, page: Int, num : Int? = nil) -> Promise<[ArticleObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d/%d", Constants.API.URL_GET_NEWS_BY_CATEGORY ,categoryId ,page,(num == nil ? Constants.GetNumber.DefaultNumber : num!))
            
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let news = Mapper<ArticleObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(news)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    public func getNewsContent(pid: Int, cid: Int, sId : Int) -> Promise<[BodyDetailArticle]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d/%d", Constants.API.URL_GET_NEWS_CONTENT ,pid , cid, sId)
            
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
//                            let header = Mapper<HeaderDetailArticle>().map(JSON: serverResponse.data as! [String : Any])
                            let bodies = Mapper<BodyDetailArticle>().mapArray(JSONArray: serverResponse.data?["Body"] as! [[String : Any]])
                            fulfill(bodies)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
    }
    
    public func getNewsRelated(pid: Int, cid: Int, sId : Int) -> Promise<[ArticleObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d/%d", Constants.API.URL_GET_NEWS_RELATED ,pid , cid, sId)
            
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let news = Mapper<ArticleObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(news)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    public func getNewsHome() -> Promise<[NewsHomeObject]>
    {
        return Promise { fulfill, reject in
            ServiceFactory.get(url: Constants.API.URL_GET_NEWS_HOME) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let news = Mapper<NewsHomeObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(news)
                            return
                        }

                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    
    public func getRadioByCategory(categoryId: Int, page: Int, num : Int? = nil) -> Promise<[ArticleObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d/%d", Constants.API.URL_GET_RADIO_BY_CATEGORY ,categoryId ,page,(num == nil ? Constants.GetNumber.DefaultNumber : num!))
            
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let news = Mapper<ArticleObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(news)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    public func getListSource() -> Promise<[SourceObject]>
    {
        return Promise { fulfill, reject in
            
            ServiceFactory.get(url: Constants.API.URL_GET_LIST_SOURCE) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let topNow = Mapper<SourceObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(topNow)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    
    public func getTopNow(page: Int, num : Int? = nil) -> Promise<[TopNowObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d", Constants.API.URL_GET_TOP_NOW ,page,(num == nil ? 10 : num!))
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let topNow = Mapper<TopNowObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(topNow)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }
    
    
    public func getListSourceNews(categoryId: Int, page: Int, num : Int? = nil) -> Promise<[ArticleObject]>
    {
        return Promise { fulfill, reject in
            let urlWithPage = String.init(format: "%@/%d/%d/%d", Constants.API.URL_GET_LIST_SOURCE_NEWS, categoryId ,page,(num == nil ? Constants.GetNumber.DefaultNumber : num!))
            ServiceFactory.get(url: urlWithPage) { (response) in
                if response.result.isSuccess, response.response?.statusCode == 200 {
                    if let serverResponse = Mapper<ServerResponse>().map(JSON: response.result.value as! [String : Any]) {
                        if serverResponse.error != nil {
                            let userInfo: [NSObject : AnyObject] =
                                [
                                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error?["Message"] as! String, comment: "") as AnyObject
                            ]
                            
                            let error = NSError(domain: "", code: 0, userInfo: userInfo)
                            reject(error)
                            return
                            
                        } else {
                            let articles = Mapper<ArticleObject>().mapArray(JSONArray: serverResponse.data as! [[String : Any]])
                            fulfill(articles)
                            return
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        reject(error)
                    }
                }
                
                if let error = response.result.error {
                    reject(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    reject(error)
                }
            }
            
        }
        
    }

}
