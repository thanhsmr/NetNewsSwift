//
//  NewsViewController.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit

class NewsViewController: PageViewController, NewsDetailCategoryViewControllerDelegate, HomeNewsViewControllerDelegate, BeautifullPeopleViewControllerDelegate {

    override func viewDidLoad() {
        self.setupPages()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupPages() {
        let newsCategories = CacheManager.sharedManager.newsCategories
        if newsCategories.count > 0 {
            let homeNews = HomeNewsViewController()
            homeNews.view.tag = 0
            homeNews.title = "For You a"
            homeNews.delegate = self
            self.controllerArray.append(homeNews)
            for category in newsCategories {
                if category.id == 7 {
                    let contentVC = BeautifullPeopleViewController()
                    contentVC.title = category.name
                    contentVC.delegate = self
                    self.controllerArray.append(contentVC)
                } else {
                    let contentVC = NewsDetailCategoryViewController()
                    contentVC.category = category
                    contentVC.title = category.name
                    contentVC.delegate = self
                    self.controllerArray.append(contentVC)
                }

                
            }
            
            self.removeErrorScreen()
        } else {
            showErrorLoadingScreen()
        }
    }
    
    
    func articleTouch(article: ArticleObject) {
        let newsDetailVC = NewsDetailViewController()
        newsDetailVC.article = article
        newsDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    
    func listenTouch() {
        
    }
    
    override func retryLoadData() {
        showLoadingView()
        CacheManager.sharedManager.getCategoriesData(completion: {
            self.setupPages()
            self.hideLoadingView()
        })
    }
}
