//
//  PageViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class PageViewController: BaseViewController, CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFakeStatusBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        if pageMenu == nil {
            setupPageView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func setupPageView() {
        if self.controllerArray.count == 0 {
            return
        }
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(Constants.Color.PageMenuBackgroundColor),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.white),
            .addBottomMenuHairline(false),
            .menuItemFont(Constants.Font.PageMenuViewFont!),
            .menuHeight(40.0),
            .selectionIndicatorHeight(2.0),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .selectedMenuItemLabelColor(UIColor.white)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect.init(x: 0, y: 20, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT), pageMenuOptions: parameters)
        pageMenu?.delegate = self

        self.view.addSubview(pageMenu!.view)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        
    }
    


}
