//
//  NetNewsMainTabbarViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class NetNewsMainTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    var newsNavigationViewcontroller : UINavigationController?
    var radioNavigationViewcontroller : UINavigationController?
    var tvNavigationViewcontroller : UINavigationController?
    var topNowNavigationViewController : UINavigationController?
    var moreNewsNavigationViewcontroller : UINavigationController?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.createTabViews()
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreenMode), name: Notification.Name(Constants.Notification.ChangeDarkMode), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createTabViews() {
        var tabbars = [UINavigationController]()
        
        newsNavigationViewcontroller = UINavigationController.init(rootViewController: NewsViewController())
        newsNavigationViewcontroller?.tabBarItem = tabbarItem(title: "News", unSelectedImageString: "ic_tabbar_news_off", selectedImageString: "ic_tabbar_news_on")
        tabbars.append(newsNavigationViewcontroller!)
        
        tvNavigationViewcontroller = UINavigationController.init(rootViewController: TVViewController())
        tvNavigationViewcontroller?.tabBarItem = tabbarItem(title: "TV", unSelectedImageString: "ic_tabbar_tv_off", selectedImageString: "ic_tabbar_tv_on")
        tabbars.append(tvNavigationViewcontroller!)
        
        radioNavigationViewcontroller = UINavigationController.init(rootViewController: RadioViewController())
        radioNavigationViewcontroller?.tabBarItem = tabbarItem(title: "Radio", unSelectedImageString: "ic_tabbar_radio_off", selectedImageString: "ic_tabbar_radio_on")
        tabbars.append(radioNavigationViewcontroller!)
        
        topNowNavigationViewController = UINavigationController.init(rootViewController: TopNowViewController())
        topNowNavigationViewController?.tabBarItem = tabbarItem(title: "Top Now", unSelectedImageString: "ic_tabbar_top_now_off", selectedImageString: "ic_tabbar_top_now_on")
        tabbars.append(topNowNavigationViewController!)
        
        moreNewsNavigationViewcontroller = UINavigationController.init(rootViewController: MoreViewController())
        moreNewsNavigationViewcontroller?.tabBarItem = tabbarItem(title: "More", unSelectedImageString: "ic_tabbar_more_off", selectedImageString: "ic_tabbar_more_on")
        tabbars.append(moreNewsNavigationViewcontroller!)
        
        self.viewControllers = tabbars
        self.selectedViewController = newsNavigationViewcontroller
        
        updateScreenMode()
    }
    
    
    func tabbarItem(title: String, unSelectedImageString: String, selectedImageString: String) -> UITabBarItem {
        let selectedImage = UIImage.init(named: selectedImageString)
        let unselectedImage = UIImage.init(named: unSelectedImageString)
        return UITabBarItem.init(title: title, image: unselectedImage, selectedImage: selectedImage)
    }
    
    
    func updateScreenMode() {
        if Context.getScreenMode() {
           self.tabBar.barTintColor = UIColor.black
            self.tabBar.tintColor = UIColor.init(red: 43/255.0, green: 39/255.0, blue: 109/255.0, alpha: 1.0)
        } else {
            self.tabBar.barTintColor = UIColor.white
            self.tabBar.tintColor = UIColor.init(red: 43/255.0, green: 39/255.0, blue: 109/255.0, alpha: 1.0)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
