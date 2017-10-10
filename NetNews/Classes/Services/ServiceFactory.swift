//
//  ServiceFactory.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import Foundation
import Alamofire

class ServiceFactory {
    
    class func post(url: String, parameters: Parameters, completion: @escaping (_ response: DataResponse<Any>) -> ()) -> Void {
        
        let header = [Constants.Parameter.Accept: Constants.Parameter.ApplicationJson,
                      Constants.Parameter.AccessTokenType: Context.getAccessToken(),
                      Constants.Parameter.ContentType : Constants.Parameter.FormUrlEncoded,
                      Constants.Parameter.UserNameHeader : Constants.Parameter.UserNameHeaderValue,
                      Constants.Parameter.PasswordHeader : Constants.Parameter.PasswordHeaderValue]
    
        
        let encoding = URLEncoding.default
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: encoding, headers: header)
            .responseJSON { response in
                completion(response)
        }
        
    }
    
    class func get(url: String, parameters: Parameters? = nil, completion: @escaping (_ response: DataResponse<Any>) -> ()) -> Void {
        
        let header = [Constants.Parameter.Accept: Constants.Parameter.ApplicationJson,
                      Constants.Parameter.AccessTokenType: Context.getAccessToken(),
                      Constants.Parameter.ContentType : Constants.Parameter.FormUrlEncoded,
                      Constants.Parameter.UserNameHeader : Constants.Parameter.UserNameHeaderValue,
                      Constants.Parameter.PasswordHeader : Constants.Parameter.PasswordHeaderValue]
        
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header)
            .responseJSON { response in
                
                completion(response)
        }
        
    }
    
    class func put(url: String, parameters: Parameters, completion: @escaping (_ response: DataResponse<Any>) -> ()) -> Void {
        
        let header = [Constants.Parameter.Accept: Constants.Parameter.ApplicationJson,
                      Constants.Parameter.AccessTokenType: Context.getAccessToken(),
                      Constants.Parameter.ContentType : Constants.Parameter.FormUrlEncoded,
                      Constants.Parameter.UserNameHeader : Constants.Parameter.UserNameHeaderValue,
                      Constants.Parameter.PasswordHeader : Constants.Parameter.PasswordHeaderValue]
        
        let encoding = URLEncoding.default
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: encoding, headers: header)
            .responseJSON { response in
                completion(response)
        }
        
    }
    
    class func patch(url: String, parameters: Parameters, completion: @escaping (_ response: DataResponse<Any>) -> ()) -> Void {
        
        let header = [Constants.Parameter.Accept: Constants.Parameter.ApplicationJson,
                      Constants.Parameter.AccessTokenType: Context.getAccessToken(),
                      Constants.Parameter.ContentType : Constants.Parameter.FormUrlEncoded,
                      Constants.Parameter.UserNameHeader : Constants.Parameter.UserNameHeaderValue,
                      Constants.Parameter.PasswordHeader : Constants.Parameter.PasswordHeaderValue]
        
        let encoding = URLEncoding.default
        
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: encoding, headers: header)
            .responseJSON { response in
                
                completion(response)
        }
        
    }
}
