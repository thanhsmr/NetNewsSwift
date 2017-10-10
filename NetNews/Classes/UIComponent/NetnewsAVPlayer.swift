//
//  NetnewsAVPlayer.swift
//  NetNews
//
//  Created by Thanhbv on 9/8/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class NetnewsAVPlayer: AVPlayerViewController {
    var video: VideoObject?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showsPlaybackControls = true
        super.touchesBegan(touches, with: event)
    }
    

}
