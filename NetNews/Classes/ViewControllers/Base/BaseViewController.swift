//
//  BaseViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var errorView : UIView?
    var baseLoadingView : UIView?
    var lbErrorView : UILabel?
    var imageError : UIImageView?
    var tapErrorLabelGesture : UITapGestureRecognizer?
    var indicatorView: UIActivityIndicatorView?
    var isFakeNavigationBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreenMode), name: Notification.Name(Constants.Notification.ChangeDarkMode), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            NetnewsMiniVideoPlayer.shared.updateBottomPosition()
            NetnewsRadioPlayerSwipe.shared.updateBottomPosition()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateScreenMode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFakeStatusBar() {
        let fakeStatusBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: 20))
        fakeStatusBarView.backgroundColor = Constants.Color.PageMenuBackgroundColor
        self.view.addSubview(fakeStatusBarView)
    }
    
    func addFakeStatusBarLight() {
        let fakeStatusBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: 20))
        fakeStatusBarView.backgroundColor = UIColor.white
        self.view.addSubview(fakeStatusBarView)
    }
    
    func addFakeNavigationBar(title: String, backgroundColor: UIColor, titleColor: UIColor, isBackButtonWhite: Bool) {
        let fakeNavigationBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: 64))
        fakeNavigationBar.backgroundColor = UIColor.white
        fakeNavigationBar.backgroundColor = backgroundColor
        
        //Title
        let lbTitle = UILabel.init(frame: CGRect.init(x: 50, y: 21 + 10, width: Constants.ScreenSize.SCREEN_WIDTH - 100, height: 22))
        lbTitle.text = title
        lbTitle.textColor = titleColor
        lbTitle.font = Constants.Font.NavigationFont
        lbTitle.textAlignment = .center
        
        //Back button
        let btnBack = UIButton.init(frame: CGRect.init(x: 0, y: 4 + 10, width: 50, height: 50))
        btnBack.setImage(UIImage.init(named: isBackButtonWhite ? "btn_back_white" : "btn_back_black"), for: .normal)
        btnBack.addTarget(self, action: #selector(navigationBackTouch), for: .touchUpInside)
        
        
        fakeNavigationBar.addSubview(lbTitle)
        fakeNavigationBar.addSubview(btnBack)
        self.view.addSubview(fakeNavigationBar)
        
        isFakeNavigationBar = true
    }
    
    func navigationBackTouch() {
        
    }
    
    func showEmtyScreen() {
        if let errorView = self.errorView {
            self.imageError?.image = UIImage.init(named: "img_error_no_content")
            self.lbErrorView?.text = "Không có nội dung"
            self.lbErrorView?.isUserInteractionEnabled = false
            
            if let _ = errorView.superview {
                
            } else {
                self.view.addSubview(errorView)
            }
        } else {
            self.errorView = UIView.init(frame: CGRect.init(x: 0, y: (isFakeNavigationBar ? 64 : 0), width: self.view.frame.size.width, height: self.view.frame.size.height - ( Utils.mDelegate().tabbarIsHidden() ? 49 : 0) - (isFakeNavigationBar ? 64 : 0)))
            self.errorView?.backgroundColor = Context.getScreenMode() ? UIColor.black : UIColor.white
            self.errorView?.backgroundColor = UIColor.white
            
            self.imageError = UIImageView.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH/2 - 50, y: (self.errorView?.frame.height)!/2 - 50 - 21, width: 100, height: 100))
            self.imageError?.image = UIImage.init(named: "img_error_no_content")
            
            self.lbErrorView = UILabel.init(frame: CGRect.init(x: 10, y: (self.imageError?.frame.origin.y)! + (self.imageError?.frame.height)! + 10, width: Constants.ScreenSize.SCREEN_WIDTH - 20, height: 42))
            self.lbErrorView?.textAlignment = .center
            self.lbErrorView?.numberOfLines = 0
            self.lbErrorView?.text = "Không có nội dung"
            self.lbErrorView?.textColor = Context.getScreenMode() ? UIColor.white : UIColor.black
            
            self.errorView?.addSubview(imageError!)
            self.errorView?.addSubview(lbErrorView!)
            
            self.view.addSubview(errorView!)
        }
        

    }
    
    func showErrorLoadingScreen() {
        if let errorView = self.errorView {
            self.imageError?.image = UIImage.init(named: "img_lost_internet")
            self.lbErrorView?.text = "Lỗi kết nối, bấm vào đây để thử lại"
            
            if let _ = errorView.superview {
                
            } else {
                self.view.addSubview(errorView)
            }
            
            self.lbErrorView?.isUserInteractionEnabled = true
            
            if let _ = self.tapErrorLabelGesture {
            } else {
                self.tapErrorLabelGesture = UITapGestureRecognizer.init(target: self, action: #selector(retryLoadData))
                self.tapErrorLabelGesture?.numberOfTapsRequired = 1
                errorView.addGestureRecognizer(self.tapErrorLabelGesture!)
            }
            
        } else {
            self.errorView = UIView.init(frame: CGRect.init(x: 0, y: (isFakeNavigationBar ? 64 : 0), width: self.view.frame.size.width, height: self.view.frame.size.height - ( Utils.mDelegate().tabbarIsHidden() ? 0 : 49) - (isFakeNavigationBar ? 64 : 0)))
            self.errorView?.backgroundColor = Context.getScreenMode() ? UIColor.black : UIColor.white
            
            self.imageError = UIImageView.init(frame: CGRect.init(x: Constants.ScreenSize.SCREEN_WIDTH/2 - 50, y: (self.errorView?.frame.height)!/2 - 50 - 21, width: 100, height: 100))
            self.imageError?.image = UIImage.init(named: "img_lost_internet")
            
            self.lbErrorView = UILabel.init(frame: CGRect.init(x: 10, y: (self.imageError?.frame.origin.y)! + (self.imageError?.frame.height)! + 10, width: Constants.ScreenSize.SCREEN_WIDTH - 20, height: 42))
            self.lbErrorView?.textAlignment = .center
            self.lbErrorView?.numberOfLines = 0
            self.lbErrorView?.text = "Lỗi kết nối, bấm vào đây để thử lại"
            
            self.tapErrorLabelGesture = UITapGestureRecognizer.init(target: self, action: #selector(retryLoadData))
            self.tapErrorLabelGesture?.numberOfTapsRequired = 1
            self.lbErrorView?.addGestureRecognizer(self.tapErrorLabelGesture!)
            self.lbErrorView?.isUserInteractionEnabled = true
            self.lbErrorView?.textColor = Context.getScreenMode() ? UIColor.white : UIColor.black
            
            self.errorView?.addSubview(imageError!)
            self.errorView?.addSubview(lbErrorView!)
            
            self.view.addSubview(errorView!)
        }
    }
    
    func removeErrorScreen() {
        if let errorView = self.errorView {
            errorView.removeFromSuperview()
        }
    }
    
    
    func retryLoadData() {
        
    }
    
    func showLoadingView() {
        if let vLoading = self.baseLoadingView {
            if let _ = vLoading.superview {
                
            } else {
                self.view.addSubview(vLoading)
            }
        } else {
            self.baseLoadingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - ( Utils.mDelegate().tabbarIsHidden() ? 0 : 49) - 20))
            indicatorView = UIActivityIndicatorView.init(frame: CGRect.init(x: self.view.frame.size.width/2 - 15, y: (self.baseLoadingView?.frame.size.height)!/2 - 15, width: 30, height: 30))
            indicatorView?.startAnimating()
            indicatorView?.color = Context.getScreenMode() ? UIColor.white : UIColor.darkGray
            self.baseLoadingView?.addSubview(indicatorView!)
            self.view.addSubview(self.baseLoadingView!)
        }
    }
    
    func hideLoadingView() {
        if let vLoading = self.baseLoadingView {
            vLoading.removeFromSuperview()
        }
    }
    
    func updateScreenMode() {
        if Context.getScreenMode() {
            self.view.backgroundColor = UIColor.black
            indicatorView?.color = UIColor.white
            self.errorView?.backgroundColor = UIColor.black
            self.lbErrorView?.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            indicatorView?.color = UIColor.darkGray
            self.errorView?.backgroundColor = UIColor.white
            self.lbErrorView?.textColor = UIColor.black
        }

    }
}
