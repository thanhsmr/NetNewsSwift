//
//  NSTimeIntervalExtension.swift
//  NetNews
//
//  Created by Thanhbv on 9/13/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import Foundation

extension TimeInterval {
    func toStringHours() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        if hours == 0 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
}
