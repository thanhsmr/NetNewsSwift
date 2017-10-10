//
//  SplashScreenViewController.swift
//  NetNews
//
//  Created by Thanhbv on 8/31/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import PromiseKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CacheManager.sharedManager.getCategoriesData(completion: {
            Utils.mDelegate().openMainView()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    


}
