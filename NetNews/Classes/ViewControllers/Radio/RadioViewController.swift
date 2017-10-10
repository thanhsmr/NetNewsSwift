//
//  RadioViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class RadioViewController: PageViewController, RadioContentViewControllerDelegate, HomeRadioViewControllerDelegate {

    override func viewDidLoad() {
        setupPages()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupPages() {
        let radioCategories = CacheManager.sharedManager.radioCategories
        if radioCategories.count > 0 {
            
            let homeRadio = HomeRadioViewController()
            homeRadio.view.tag = 2
            homeRadio.title = "For You  a"
            homeRadio.delegate = self
            self.controllerArray.append(homeRadio)
            for category in radioCategories {
                let contentVC = RadioContentViewController()
                contentVC.title = category.name
                contentVC.category = category
                contentVC.delegate = self
                self.controllerArray.append(contentVC)
                
            }
            
            self.removeErrorScreen()
        } else {
            showErrorLoadingScreen()
        }

    }
    
    override func retryLoadData() {
        showLoadingView()
        CacheManager.sharedManager.getCategoriesData(completion: {
            self.setupPages()
            self.hideLoadingView()
        })
    }
    
    func touchRadio(articles: [ArticleObject]?) {
        NetnewsRadioPlayerSwipe.shared.show(articles: articles!, tabbarVisible: true)
    }

}
