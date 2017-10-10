//
//  AuthService.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AuthService {
    
    class func requestAccessToken(_ authorizationCode: String, source: String, completion : @escaping (_ response: Token) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "authorization_code": authorizationCode,
            "source": source
        ]
        
        ServiceFactory.post(url: Constants.API.RequestAccessToken, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.error is NSNull {
                        let userInfo: [NSObject : AnyObject] =
                            [
                                NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Error", value: serverResponse.error as! String, comment: "") as AnyObject
                        ]
                        
                        let error = NSError(domain: "", code: 0, userInfo: userInfo)
                        fail(error)
                        return

                    } else {
                        if let token = Mapper<Token>().map(JSONObject: serverResponse.data) {
                            completion(token)
                            return
                        }
                    }
                }
            }
            
            if let error = response.result.error {
                fail(error)
            } else {
                let error = NSError(domain: "", code: 0, userInfo: nil)
                fail(error)
            }
        }
    }
    
}
