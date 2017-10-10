//
//  RadioPlayerView.swift
//  NetNews
//
//  Created by Thanhbv on 9/11/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import KDEAudioPlayer
import MarqueeLabel

protocol RadioPlayerViewDelegate {
    func showQueue(isShow : Bool)
}

class RadioPlayerView: UIView, AudioPlayerDelegate, UITableViewDelegate, UITableViewDataSource, RadioQueueTableViewCellDelegate, CarModeDelegate {


    
    @IBOutlet weak var listQueueHeight: NSLayoutConstraint!
    @IBOutlet weak var miniPlayerView: UIView!
    @IBOutlet weak var listRadioView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbTitle: MarqueeLabel!

    @IBOutlet weak var lbPlaylist: UILabel!
    @IBOutlet weak var lbTimeCurrent: UILabel!
    @IBOutlet weak var lbTimeTotal: UILabel!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var lbTimeCurrentWidth: NSLayoutConstraint!
    @IBOutlet weak var lbTimeTotalWidth: NSLayoutConstraint!
    @IBOutlet weak var btnPlay: UIButton!


    var isShowQueue = false
    var arrArticle: [ArticleObject] = []
    var playingIndex = 0;
    var viewProgress = UIView()

    var delegate: RadioPlayerViewDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        CacheManager.sharedManager.radioPlayerController.delegate = self
        viewProgress.backgroundColor = UIColor.brown
        viewTime.addSubview(viewProgress)
        viewTime.sendSubview(toBack: viewProgress)
        setupTableview()
    }
    
    
    
    deinit {
    }
    
     override var canBecomeFirstResponder: Bool {
        return true
    }
    

    
    
    func setupTableview(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register(UINib.init(nibName: "RadioQueueTableViewCell", bundle: nil), forCellReuseIdentifier: "RadioQueueTableViewCell")
        tableView.backgroundColor = Context.getScreenMode() ? UIColor.black : UIColor.white
    }
    
    func setData(arrArticle : [ArticleObject]) {
        self.arrArticle = arrArticle
        var items = [AudioItem]()
        for article in arrArticle {
            if let mediaURL = article.media_url {
                if mediaURL.length > 0 {
                    let item = AudioItem.init(mediumQualitySoundURL: URL.init(string: mediaURL))
                    item?.title = article.title
                    if let imageLink = article.image169 {
                        do {
                            if let imageURLUnWrap = URL.init(string: imageLink) {
                                let data = try Data.init(contentsOf:imageURLUnWrap)
                                item?.artworkImage = Image.init(data: data)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    if let itemUnWrapped = item {
                        items.append(itemUnWrapped)
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            CacheManager.sharedManager.radioPlayerController.play(items: items)
            self.tableView.reloadData()
        }

    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
        switch state {
        case .buffering:
            self.lbTitle.text = audioPlayer.currentItem?.title
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
        self.lbTimeTotalWidth.constant = (self.lbTimeTotal.text?.width(withConstraintedHeight: self.lbTimeTotal.frame.size.height, font: self.lbTimeTotal.font))! + 5
        self.lbTimeCurrentWidth.constant = self.lbTimeTotalWidth.constant
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        
        self.setViewProgress(progress: CGFloat(percentageRead/100.0))
        self.lbTimeCurrent.text = time.toStringHours()
    }
    
    func setViewProgress(progress: CGFloat) {
        self.viewProgress.frame = CGRect.init(x: 0, y: 0, width: progress * Constants.ScreenSize.SCREEN_WIDTH, height: self.viewTime.frame.size.height)
    }
    
    @IBAction func playTUI(_ sender: Any) {
        if CacheManager.sharedManager.radioPlayerController.state == KDEAudioPlayer.AudioPlayerState.paused {
            CacheManager.sharedManager.radioPlayerController.resume()
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_pause"), for: .normal)
        } else {
            CacheManager.sharedManager.radioPlayerController.pause()
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        }
    }
    @IBAction func nextTUI(_ sender: Any) {
        CacheManager.sharedManager.radioPlayerController.nextOrStop()
        self.resetTimeAndProgress()
        if playingIndex < self.arrArticle.count - 1 {
            self.hightlightCell(index: playingIndex + 1)
        }
        
    }
    
    @IBAction func previousTUI(_ sender: Any) {
        CacheManager.sharedManager.radioPlayerController.previous()
        self.resetTimeAndProgress()
        if playingIndex > 0 {
            self.hightlightCell(index: playingIndex - 1)
        }
    }

    @IBAction func showRead(_ sender: Any) {
        let article = self.arrArticle[playingIndex]
        
        if let readAvaible = article.is_read {
            if readAvaible.boolValue {
                let newsDetailVC = NewsDetailViewController()
                newsDetailVC.article = article
                newsDetailVC.hidesBottomBarWhenPushed = true
                Utils.mDelegate().getRootTabbarViewController()?.navigationController?.pushViewController(newsDetailVC, animated: true)
            }
        }
    }
    
    @IBAction func showQueueTUI(_ sender: Any) {
        isShowQueue = !isShowQueue
        delegate?.showQueue(isShow: isShowQueue)
        self.layoutIfNeeded()
        
        self.listQueueHeight.constant = self.isShowQueue ? (self.frame.size.height - self.miniPlayerView.frame.size.height) - 20 : 0
        self.lbPlaylist.isHidden = !self.isShowQueue
//        self.btnShowQueue.setImage(UIImage.init(named: self.isShowQueue ? "ic_hide_queue" : "ic_show_queue"), for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }) { (finished) in
            
//            self.tableView.reloadData()
        }

    }
    

    @IBAction func showCarMode(_ sender: Any) {
        (sender as! UIButton).isUserInteractionEnabled = false
        let carMode = CarMode.fromNib(nibNameOrNil: "CarMode") as? CarMode
        carMode?.delegate = self
        carMode?.frame = CGRect.init(x: 0, y: Constants.ScreenSize.SCREEN_HEIGHT, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT)
        
        UIView.animate(withDuration: 0.3, animations: {
            carMode!.frame = CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT)
        }) { (finish) in
            (sender as! UIButton).isUserInteractionEnabled = true
        }
        carMode?.setupUI()
    }

    
    func stop() {
        CacheManager.sharedManager.radioPlayerController.stop()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : RadioQueueTableViewCell!
        if let currentCell = tableView.dequeueReusableCell(withIdentifier: "RadioQueueTableViewCell") {
            cell = currentCell as! RadioQueueTableViewCell
        } else {
            cell = UINib(nibName: "RadioQueueTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RadioQueueTableViewCell
        }
        let data = arrArticle[indexPath.row]
        cell.configWithData(data: data)
        
        cell.hightlightCell(isHightlight: indexPath.row == playingIndex)
        cell.delegate = self
        return cell;
    }
    
    
    func hightlightCell(index: Int) {
        
        if let cell = tableView.cellForRow(at: IndexPath.init(row: playingIndex, section: 0)) {
            (cell as! RadioQueueTableViewCell).hightlightCell(isHightlight: false)
        }
        
        if let cell = tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) {
            (cell as! RadioQueueTableViewCell).hightlightCell(isHightlight: true)
        }
        
        playingIndex = index
        
    }
    
    func touchRadio(article : ArticleObject?) {
        let indexToPlay = self.arrArticle.index { (currentArticle) -> Bool in
            return currentArticle.id == article?.id
        }
        
        var items = [AudioItem]()
        for article in arrArticle {
            if let url = article.media_url {
                let item = AudioItem.init(mediumQualitySoundURL: URL.init(string: url))
                item?.title = article.title
                if let itemUnWrap = item {
                    items.append(itemUnWrap)
                }
            }
        }
        
        CacheManager.sharedManager.radioPlayerController.play(items: items, startAtIndex: indexToPlay!)
        self.hightlightCell(index: indexToPlay!)
        self.resetTimeAndProgress()
    }
    
    func resetTimeAndProgress() {
        self.lbTimeCurrent.text = "00:00"
        self.lbTimeTotal.text = "00:00"
        self.setViewProgress(progress: 0.0)
    }
    
    func carModeExit(carMode : UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            carMode.frame = CGRect.init(x: 0, y: Constants.ScreenSize.SCREEN_HEIGHT, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT)
        }) { (finished) in
            carMode.removeFromSuperview()
        }
        
        
        CacheManager.sharedManager.radioPlayerController.delegate = self
        
        if CacheManager.sharedManager.radioPlayerController.state == KDEAudioPlayer.AudioPlayerState.playing {
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_pause"), for: .normal)
        } else {
            CacheManager.sharedManager.radioPlayerController.pause()
            self.btnPlay.setImage(UIImage.init(named: "ic_radio_play"), for: .normal)
        }
        self.lbTitle.text = CacheManager.sharedManager.radioPlayerController.currentItem?.title
        self.lbTimeTotal.text =  CacheManager.sharedManager.radioPlayerController.currentItemDuration?.toStringHours()
        self.lbTimeCurrent.text = CacheManager.sharedManager.radioPlayerController.currentItemProgression?.toStringHours()
        
        if let duration = CacheManager.sharedManager.radioPlayerController.currentItemDuration, let current = CacheManager.sharedManager.radioPlayerController.currentItemProgression {
            self.setViewProgress(progress: CGFloat(current/duration))
        } else {
            self.setViewProgress(progress: 0)
        }
        
        if let currentIndex = CacheManager.sharedManager.radioPlayerController.currentItemIndexInQueue {
            self.hightlightCell(index: currentIndex)
        }
    }
}
