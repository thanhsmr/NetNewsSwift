//
//  BeautifullPeopleViewController.swift
//  NetNews
//
//  Created by Thanhbv on 9/14/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import AVFoundation
import PromiseKit


protocol BeautifullPeopleViewControllerDelegate {
    func articleTouch(article: ArticleObject)
}

protocol PinterestLayoutDelegate {
    //Method to ask the delegate for the height of the image
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath) -> CGFloat
    
    func getNumberOfColumn() -> Int
}

class BeautifullPeopleViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate, BeautifullPeopleCollectionViewCellDelegate {

    var collectionView: UICollectionView!
    var page = 1
    let itemsPerRow = 2
    var arrayData = [ArticleObject]()
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    var delegate : BeautifullPeopleViewControllerDelegate?
    var isLoadMoreAvaible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(){
        let layout = PinterestLayout.init(padding: 2.0)
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT - 109),  collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.Color.TableViewBackground
        self.view.addSubview(collectionView)
        if let layout = self.collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.register(UINib(nibName:"BeautifullPeopleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BeautifullPeopleCollectionViewCell")

        collectionView.register(Utils.stringClassFromString("FooterLoadMoreCollectionView"), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterLoadMoreCollectionView")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupPullToRefresh()
        addLoadMore()
    }
    
    //MARK: Pull to refresh
    
    func setupPullToRefresh() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        collectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
                self?.page = 1
                self?.getData()
            
            }, loadingView: loadingView)
        collectionView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        collectionView.dg_setPullToRefreshBackgroundColor(collectionView.backgroundColor!)
        
    }
    
    deinit {
        if collectionView != nil {
            collectionView.dg_removePullToRefresh()
        }
    }
    
    
    //MARK: Load more
    
    func addLoadMore(){
        collectionView.addInfiniteScroll { (collectionView) -> Void in
            self.page += 1
            self.getData()
        }
        
        collectionView.setShouldShowInfiniteScrollHandler { (collectionView) -> Bool in
            return self.isLoadMoreAvaible
        }
    }
    
    
    
    func setupData() {
        showLoadingView()
        self.getData()
    }
    
    func getData() {
        firstly {
            return  NetnewsService.shared.getNewsByCategory(categoryId: 7, page: page )
            }.then { news -> Void in
                self.parseData(articles: news)
                
                if news.count == 0 && self.page == 1 {
                    self.showEmtyScreen()
                }
                
            }.always {
                self.hideLoadingView()
            }.catch { (error) in
                NSLog("%@", error.localizedDescription)
                
                if self.arrayData.count == 0 {
                    self.showErrorLoadingScreen()
                }
                
                if self.collectionView != nil {
                    self.collectionView.dg_stopLoading()
                    self.collectionView.finishInfiniteScroll()
                }
        }
    }
    
    override func retryLoadData() {
        setupData()
    }
    
    func parseData(articles: [ArticleObject]) {
        if page == 1 {
            self.arrayData.removeAll()
            self.collectionView.dg_stopLoading()
            isLoadMoreAvaible = true
            
            self.arrayData.append(contentsOf: articles)
            self.collectionView.reloadData()
        } else {
            if articles.count < Constants.GetNumber.DefaultNumber {
                isLoadMoreAvaible = false
            }
            self.collectionView.finishInfiniteScroll()
            
            //Make array of new IndexPath
//            var indexPaths = [NSIndexPath]()
//            for i in 0..<articles.count {
//                indexPaths.append(IndexPath.init(row: self.arrayData.count + i, section: 0) as NSIndexPath)
//            }
            
            self.arrayData.append(contentsOf: articles)
            self.collectionView.reloadData()
            
            //Add cell for Collection view
//            self.collectionView.performBatchUpdates({
//                self.collectionView.insertItems(at: indexPaths as [IndexPath])
//            }, completion: nil)
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeautifullPeopleCollectionViewCell", for: indexPath) as! BeautifullPeopleCollectionViewCell
        cell.configWithData(article: self.arrayData[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath) -> CGFloat
    {
        let paddingSpace = self.sectionInsets.left * CGFloat(self.itemsPerRow + 1)
        let availableWidth = self.collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        let boundingRect =  CGRect(x: 0, y: 0, width: widthPerItem, height: CGFloat.greatestFiniteMagnitude);
        let rect = AVMakeRect(aspectRatio: CGSize.init(width: widthPerItem, height: widthPerItem * CGFloat(drand48()*0.5 + 1)), insideRect: boundingRect);
        return rect.height
    }
    
    
    func getNumberOfColumn() -> Int {
        return self.itemsPerRow
    }
    
    func articleTouch(article: ArticleObject) {
        delegate?.articleTouch(article: article)
    }
    

}



