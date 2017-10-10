//
//  Context.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import Foundation

class Context {
    
    //AccessToken
    class func clearAccessToken() {
        saveAccessToken("")
    }
    
    class func saveAccessToken(_ token: String) -> Void {
        let preferences = UserDefaults.standard
        preferences.set(token,forKey: Constants.UserDefaultsKey.AccessToken)
        preferences.synchronize()
    }
    
    class func getAccessToken() -> String {
        let token = UserDefaults.standard.string(forKey: Constants.UserDefaultsKey.AccessToken)
        return token ?? ""
    }
    
    class func saveScreenMode(_ isDarkMode: Bool) -> Void {
        let preferences = UserDefaults.standard
        preferences.set(isDarkMode,forKey: Constants.UserDefaultsKey.IsDarkMode)
        preferences.synchronize()
    }
    
    class func getScreenMode() -> Bool {
        let token = UserDefaults.standard.bool(forKey: Constants.UserDefaultsKey.IsDarkMode)
        return token
    }
}
