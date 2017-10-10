//
//  Constants.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Domain {
        static let Staging = "http://10.0.0.2:8080"
        
        static let Testing = ""
        static let Production = ""

    }
    
    struct API {
        
        #if NETNEWS_PLATFORM_TESTING
        static let baseURL = Domain.Testing
        #elseif NETNEWS_PLATFORM_STAGING
        static let baseURL = Domain.Staging
        #elseif NETNEWS_PLATFORM_PRODUCTION
        static let baseURL = Domain.Production
        #endif
        
        // authentication APIs
        static let RequestAccessToken = baseURL + "/token"
        static let RefreshAccessToken = baseURL + "/refreshtoken"
        static let GetTokenInfo = baseURL + "/tokeninfo"
        static let GetMyInfo = baseURL + "/myinfo"
        static let GetFriends = baseURL + "/friends"
        
        //Categoy
        static let URL_GET_CATEGORY_NEWS             = baseURL + "getCategory"
        static let URL_GET_CATEGORY_RADIO            = baseURL + "getCategoryRadioNew"
        static let URL_GET_CATEGORY_TV               = baseURL + "getCategoryVideo"
        
        //TV
        static let URL_GET_VIDEO_TV                  = baseURL + "GetListVideo"
        static let URL_GET_VIDEO_TV_BY_CATEGORY      = baseURL + "getVideoOfCategory"
        static let URL_GET_TV_RELATED                = baseURL + "getVideoRelate"
        
        //News
        static let URL_GET_NEWS_HOME                 = baseURL + "getNewsHome"
        static let URL_GET_NEWS_BY_CATEGORY          = baseURL + "getListCate"
        static let URL_GET_NEWS_CONTENT              = baseURL + "getContent"
        static let URL_GET_NEWS_RELATED              = baseURL + "RelateReadNews"
        
        //Radio
        static let URL_GET_RADIO_BY_CATEGORY         = baseURL + "getRadioNew"
        
        //TOP NOW
        static let URL_GET_LIST_SOURCE               = baseURL + "getListSource"
        static let URL_GET_TOP_NOW                   = baseURL + "getHomeTop"
        static let URL_GET_LIST_SOURCE_NEWS          = baseURL + "getListNewsOfSource"
        
    }
    
    struct GetNumber {
        static let DefaultNumber = 20
    }
    
    struct Parameter {
        // headers
        static let Accept = "Accept"
        static let ApplicationJson = "application/json"
        static let AccessTokenType = "access-token"
        static let ContentType = "Content-Type"
        static let FormUrlEncoded = "application/x-www-form-urlencoded"
        static let UserNameHeader = "user"
        static let PasswordHeader = "password"
        static let UserNameHeaderValue = "tinngan"
        static let PasswordHeaderValue = "191f1f632d69180e6228d26849d34d081a3b8d8aa9197eba0f70530ffe698ba80108bfb075c43e82081e245ccb63f6a39107327b2c1d053469bdf4f09bc1e820"
        
        
        
        // params
        static let Name = "name"
        static let UserName = "username"
        static let Email = "email"
        static let Password = "password"
    }
    
    // Storyboard identifiers
    struct StoryboardID {
        
        static let LoginVC = "LoginVC"
        static let DashboardVC = "DashboardVC"
        static let AISetupVC = "AISetupVC"
        static let GameSceneVC = "GameSceneVC"
    }
    
    // Segue identifier
    struct Segue {
        static let unwindToLogin = "unwindToLoginVC"
        static let DashboardToChallengeAccepted = "DashboardToChallengeAccepted"
        static let DashboardToLoadingMatch = "DashboardToLoadingMatch"
        static let ChallengeAcceptedToLoadingMatch = "ChallengeAcceptedToLoadingMatch"
        static let LoadingMatchToMainGame = "LoadingMatchToMainGame"
    }
    
    // UserDefaults Keys
    struct UserDefaultsKey {
        static let AccessToken = "AccessToken"
        static let IsDarkMode = "IsDarkMode"
    }
    
    struct Message {
        static let LoginAgain = "You are logged into your account on another device. Please login again."
        static let NoHistoryToShow = "No history to show"
    }
    
    struct Notification {
        static let ChangeDarkMode = "ChangeDarkMode"
    }
    
    struct HttpErrorCode {
        static let Unauthorized = 401
    }
    
    static let dateFormat = "yyyy-MM-dd"
    
    struct BarButton {
        static let Width = CGFloat(40)
        static let Height = CGFloat(40)
    }
    
    struct Font {
        static let CORETEXT_FONT_NAME = "HelveticaNeue"
        static let CORETEXT_LIGHT_FONT_NAME = "HelveticaNeue-Light"
        static let CORETEXT_BOLD_FONT_NAME = "HelveticaNeue-Bold"
        static let CORETEXT_MEDIUM_FONT_NAME = "HelveticaNeue-Medium"
        
        static let NavigationFont = UIFont.init(name: CORETEXT_BOLD_FONT_NAME, size: 14)
        static let BoldFont = UIFont.boldSystemFont(ofSize: 14)
        static let NormalFont = UIFont.systemFont(ofSize: 14)
        static let PageMenuViewFont = UIFont.init(name: CORETEXT_MEDIUM_FONT_NAME, size: 16)
        static let MenuTitleFont = UIFont.init(name: CORETEXT_FONT_NAME, size: 14)
        static let NewsTitleFont = UIFont.init(name: CORETEXT_FONT_NAME, size: 17)
        static let NewsPaperNameFont = UIFont.init(name: CORETEXT_FONT_NAME, size: 13)
        static let NewsSubTitleFont = UIFont.init(name: CORETEXT_FONT_NAME, size: 14)
        static let RadioTitleFont = UIFont.init(name: CORETEXT_FONT_NAME, size: 17)
        static let NewsRelatedTitleFont = UIFont.init(name: CORETEXT_FONT_NAME, size: 15)
        
    }
    
    struct Color {
        static let PageMenuBackgroundColor = UIColor(red: 37.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 1.0)
        static let TableViewBackground = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        static let NewsPaperNameColor = UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1.0)
        static let NewsSubTitleColor = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        static let NewsDetailTopTitleColor = UIColor(red: 43.0/255.0, green: 39.0/255.0, blue: 109.0/255.0, alpha: 1.0)
        static let NewsDetailTopTimeColor = UIColor(red: 106.0/255.0, green: 106.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        static let NoteTitleColor = UIColor(red: 43.0/255.0, green: 39.0/255.0, blue: 109.0/255.0, alpha: 1.0)
        static let OverViewHeaderTitleColor = UIColor(red: 219.0/255.0, green: 39.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        static let RadioTitleColor = UIColor.black
        static let RadioTitleHighlightColor = UIColor(red: 65.0/255.0, green: 57.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        static let RadioTimeColor = UIColor.darkGray
        static let RadioViewColor = UIColor.lightGray
        
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    }
    
}
