//
//  CarMode.swift
//  NetNews
//
//  Created by Thanhbv on 9/21/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import KDEAudioPlayer

protocol CarModeDelegate {
    func carModeExit(carMode : UIView)
}

class CarMode: UIView, AudioPlayerDelegate {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTimeTotal: UILabel!
    @IBOutlet weak var lbTimeCurrent: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    
    var delegate: CarModeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        CacheManager.sharedManager.radioPlayerController.delegate = self
    }
    
    func setupUI()
    {
        UIApplication.shared.keyWindow?.addSubview(self)
        imageMain.image = CacheManager.sharedManager.radioPlayerController.currentItem?.artworkImage
        lbName.text = CacheManager.sharedManager.radioPlayerController.currentItem?.title
        lbTimeTotal.text = CacheManager.sharedManager.radioPlayerController.currentItemDuration?.toStringHours()
        self.lbTimeCurrent.text = CacheManager.sharedManager.radioPlayerController.currentItemProgression?.toStringHours()
        
        if CacheManager.sharedManager.radioPlayerController.state == KDEAudioPlayer.AudioPlayerState.playing {
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_pause"), for: .normal)
        } else {
            CacheManager.sharedManager.radioPlayerController.pause()
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        }
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
        switch state {
        case .buffering:
            self.lbName.text = audioPlayer.currentItem?.title
        case .paused:
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        case .playing:
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_pause"), for: .normal)
        case .stopped:
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        case .failed(_):
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        default:
            break
        }
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem) {
        self.lbTimeTotal.text = duration.toStringHours()
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        self.lbTimeCurrent.text = time.toStringHours()
    }

    @IBAction func btnExitTUI(_ sender: Any) {
        self.delegate?.carModeExit(carMode: self)
    }
    @IBAction func btnShareTUI(_ sender: Any) {
        
    }
    @IBAction func btnPlayTUI(_ sender: Any) {
        if CacheManager.sharedManager.radioPlayerController.state == KDEAudioPlayer.AudioPlayerState.paused {
            CacheManager.sharedManager.radioPlayerController.resume()
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_pause"), for: .normal)
        } else {
            CacheManager.sharedManager.radioPlayerController.pause()
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        }
    }
    @IBAction func btnPreTUI(_ sender: Any) {
        CacheManager.sharedManager.radioPlayerController.previous()
        resetTimeAndProgress()
    }
    @IBAction func btnNextTUI(_ sender: Any) {
        CacheManager.sharedManager.radioPlayerController.nextOrStop()
        resetTimeAndProgress()
    }
    
    func resetTimeAndProgress() {
        self.lbTimeCurrent.text = "00:00"
        self.lbTimeTotal.text = "00:00"
        imageMain.image = CacheManager.sharedManager.radioPlayerController.currentItem?.artworkImage
    }
}
