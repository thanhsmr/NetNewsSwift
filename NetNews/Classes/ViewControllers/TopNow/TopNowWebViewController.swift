//
//  TopNowWebViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/12/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

class TopNowWebViewController: BaseViewController {
    
    var webView: UIWebView?
    var article: ArticleObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        addFakeNavigationBar(title: "", backgroundColor: UIColor.gray, titleColor: UIColor.blue, isBackButtonWhite: true)
        initWebView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initWebView() {
        webView = UIWebView.init(frame: CGRect.init(x: 0, y: 64, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 64))
        self.view.addSubview(webView!)
        if let article = self.article {
            webView?.loadRequest(URLRequest.init(url: URL.init(string: article.url!)!))
        }
    }
    
    override func navigationBackTouch() {
        self.navigationController?.popViewController(animated: true)
    }

}
