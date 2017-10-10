//
//  VideoTableViewCell.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import Imaginary
import AVKit
import AVFoundation

protocol VideoTableViewCellDelegate {
    func btnPlayTouch(indexPlayed : Int)
    func btnDetailTouch(video: VideoObject)
}

class VideoTableViewCell: BaseTableViewCell {

    @IBOutlet weak var viewCensor: UIView!
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbTitle: NewsTitleLabel!
    @IBOutlet weak var lbTime: UILabel!
    var video: VideoObject?
    var delegate: VideoTableViewCellDelegate?
    var tvTag = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configWithData(data: Any) {
        if data is VideoObject {
            self.video = data as? VideoObject
            imageMain.setImage(url: URL.init(string: (self.video?.image)!), placeholder: UIImage.init(named: "video_place_holder"))
            lbTitle.text = self.video?.title
            
            updateScreenMode()
        }
    }
    
    func configBackgroundForRelatedView() {
        self.contentView.backgroundColor = UIColor.black
        self.viewAll.backgroundColor = UIColor.black
        self.lbTitle.backgroundColor = UIColor.black
        self.lbTitle.textColor = UIColor.white
        self.viewCensor.isHidden = false
    }
    
    @IBAction func btnPlayTouch(_ sender: Any) {
        self.delegate?.btnPlayTouch(indexPlayed: self.contentView.tag)
        addVideoView()
    }
    
    func playInVideoRelated() {
        addVideoView()
        hideCensor()
    }
    
    
    func showCensor() {
        if self.viewCensor.isHidden {
            UIView.animate(withDuration: 0.0) {
                self.viewCensor.isHidden = false
            }
        }
    }
    
    func hideCensor() {
        if !self.viewCensor.isHidden {
            UIView.animate(withDuration: 0.0) {
                self.viewCensor.isHidden = true
            }
        }
    }
    
    @IBAction func btnDetailTouch(_ sender: Any) {
        self.delegate?.btnDetailTouch(video: self.video!)
    }

    func addVideoView() {
        if let videoPlayerController = CacheManager.sharedManager.videoPlayerController {
            

            if videoPlayerController.view.tag == self.contentView.tag {
                return
            }

            
            NetnewsMiniVideoPlayer.shared.hide()
            NetnewsRadioPlayerSwipe.shared.hide()
            
            videoPlayerController.player?.pause()
            videoPlayerController.view.removeFromSuperview()
            
            videoPlayerController.view.alpha = 1
            
            videoPlayerController.view.frame.size.width = Constants.ScreenSize.SCREEN_WIDTH - 30
            videoPlayerController.view.frame.size.height = (Constants.ScreenSize.SCREEN_WIDTH - 30) * 9 / 16
            videoPlayerController.view.frame.origin.x = self.viewAll.frame.origin.x
            videoPlayerController.view.frame.origin.y = self.viewAll.frame.origin.y
            
            videoPlayerController.view.tag = self.contentView.tag
            videoPlayerController.videoPlayerControllerFrom = .fromTV
            videoPlayerController.tvTag = self.tvTag
            videoPlayerController.showsPlaybackControls = false
            
            let videoPlayer = AVPlayer.init(url: URL.init(string: (self.video?.media_url)!)!)
            videoPlayerController.player = videoPlayer
            self.contentView.addSubview(videoPlayerController.view)
            videoPlayerController.video = self.video
            videoPlayer.play()
        } else {

        }

    }
    
    override func updateScreenMode() {
        super.updateScreenMode()
        updateLabelForScreenMode(label: lbTitle)
        updateViewForScreenMode(view: self.contentView)
        updateViewForScreenMode(view: self.viewAll)
    }
}
