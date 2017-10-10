//
//  NSDateExtension.swift
//  NetNews
//
//  Created by Thanhbv on 9/13/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
        
        let myString = formatter.string(from: self)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = format
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
}

