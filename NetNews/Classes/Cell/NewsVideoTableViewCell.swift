//
//  NewsVideoTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary
import AVKit
import AVFoundation

protocol NewsVideoTableViewCellDelegate {
    func playVideoTouch(url: String)
}

class NewsVideoTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imageMain: UIImageView!
    var delegate: NewsVideoTableViewCellDelegate?
    var bodyDetailArticle: BodyDetailArticle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configWithData(data: Any) {
        if data is BodyDetailArticle {
            self.bodyDetailArticle = (data as! BodyDetailArticle)
            imageMain.setImage(url: URL.init(string: (data as! BodyDetailArticle).content!) , placeholder: UIImage.init(named: "video_place_holder"))
            updateScreenMode()
        }
    }

    @IBAction func playTouch() {
//        delegate?.playVideoTouch(url: (self.bodyDetailArticle?.media)!)
        addVideoView()
    }
    
    func addVideoView() {
        if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
            
            NetnewsMiniVideoPlayer.shared.hide()
            NetnewsRadioPlayerSwipe.shared.hide()
            
            videoPlayerController.player?.pause()
            videoPlayerController.view.removeFromSuperview()
            
            videoPlayerController.view.alpha = 1
            
            videoPlayerController.view.frame = self.imageMain.frame
            
            videoPlayerController.view.tag = self.contentView.tag
            videoPlayerController.videoPlayerControllerFrom = .fromNewsDetail
            
            let videoPlayer = AVPlayer.init(url: URL.init(string: (self.bodyDetailArticle?.media)!)!)
            videoPlayerController.player = videoPlayer
            self.addSubview(videoPlayerController.view)
            videoPlayer.play()
        } else {
            
        }
        
    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateViewForScreenMode(view: self.contentView)
    }
}
