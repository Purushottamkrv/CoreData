//
//  HomeViewController.swift
//  PayGyftTest
//
//  Created by Purushottam on 25/08/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import MBProgressHUD

class HomeViewController: UIViewController {
    @IBOutlet weak var CategorySlugListCollectionView: UICollectionView!
    @IBOutlet weak var SelectedCategoryListCollectionView: UICollectionView!
    
    fileprivate  var categoryListData:CategoryListModelRootClass? = nil
    fileprivate  var categoryDetailData:CategoryDetailRootClass? = nil
    fileprivate  var categoryDetailArray = [CategoryListModelCategory]()
    fileprivate var CategoryDetailDataArray = [CategoryDetailData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategorySlugListCollectionView.register(UINib(nibName: Constant.CategorySlugCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constant.CategorySlugCollectionViewCell)
        
        SelectedCategoryListCollectionView.register(UINib(nibName: "CategoryDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryDetailCollectionViewCell")
        
        let nsmanagedObjectData  = CoreDBhelper.shared.getDataFromDb(listName: "CategoryList")
        categoryDetailArray = (CoreDBhelper.shared.convertDBDataToDBUser(object: nsmanagedObjectData))
        
       let categoryListDetailObjectData  = CoreDBCategoryDetailhelper.shared.getDataFromDb(listName: "CategoryDetail")
        CategoryDetailDataArray = (CoreDBCategoryDetailhelper.shared.convertDBDataToDBUser(object: categoryListDetailObjectData))
        print(categoryDetailArray)
        categoryListDataNetworkCall()
    }
    
}

//MARK:- Coolection view delegaet and data source

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case CategorySlugListCollectionView:
            return categoryDetailArray.count
        default:
            return CategoryDetailDataArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case CategorySlugListCollectionView:
            let CategorySlugCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CategorySlugCollectionViewCell, for: indexPath) as! CategorySlugCollectionViewCell
            CategorySlugCollectionViewCell.CategorySlugName.text = categoryDetailArray[indexPath.row].categorySlug
            return CategorySlugCollectionViewCell
            
        default:
            let CategoryDetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CategoryDetailCollectionViewCell, for: indexPath) as! CategoryDetailCollectionViewCell
            CategoryDetailCollectionViewCell.offerLabel.text = CategoryDetailDataArray[indexPath.row].offer
            CategoryDetailCollectionViewCell.storeNameLabel.text = CategoryDetailDataArray[indexPath.row].storeName
            CategoryDetailCollectionViewCell.logoImageView .sd_setImage(with: URL(string: CategoryDetailDataArray[indexPath.row].logo), placeholderImage: nil, options: .refreshCached ,completed: nil)
            return CategoryDetailCollectionViewCell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case CategorySlugListCollectionView:
            return CGSize(width: CategorySlugListCollectionView.bounds.width, height: 70)
        default:
            return CGSize(width: SelectedCategoryListCollectionView.bounds.width/2, height: 200)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case CategorySlugListCollectionView:
            print("first")
        default:
            print("second")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay c: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case CategorySlugListCollectionView:
            print("index path row",indexPath.row)
            categoryListDetailNetworkCall(categorySlug: categoryDetailArray[indexPath.row].categorySlug)
        default:
            print("second")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying c: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    
}

extension HomeViewController {
    
    fileprivate func categoryListDataNetworkCall()  {
        Service.NetworkCall(apiUrl:"https://paygyft.com/api/v1/user/store/search/popular", header: Headers.header, onCompletion: { response in
            
            print(response)
            CoreDBhelper.shared.deleteAllData(entity: "CategoryDetail")
            CoreDBhelper.shared.saveCategoryDataToCoreDB(object: response)
            self.categoryListData = CategoryListModelRootClass.init(fromJson: response)
            self.categoryDetailArray = self.categoryListData!.categories
            self.CategorySlugListCollectionView.reloadData()
            
        }, failure: {
            error in
            
        })
    }
    
    fileprivate func categoryListDetailNetworkCall(categorySlug:String) {
        
        MBProgressHUD .showAdded(to: self.view, animated: true)
        Service.NetworkCall(apiUrl:"https://paygyft.com/api/v1/user/store/search/" + categorySlug , header: Headers.header, onCompletion: { response in
            print(response)
            
            MBProgressHUD .hide(for: self.view, animated: true)
            CoreDBCategoryDetailhelper.shared.deleteAllData(entity: "CategoryDetail")
            CoreDBCategoryDetailhelper.shared.saveCategoryDataToCoreDB(object: response)
            
          //  CoreDBCategoryDetailWholeDatahelper.shared.deleteAllData(entity: "CategoryListDetailData")
         //   CoreDBCategoryDetailWholeDatahelper.shared.saveCategoryDataToCoreDB(object: response)


            self.categoryDetailData = CategoryDetailRootClass.init(fromJson: response)
            self.CategoryDetailDataArray = self.categoryDetailData!.data
            

            self.SelectedCategoryListCollectionView.reloadData()
            
        }, failure: {
            
            error in
            MBProgressHUD .hide(for: self.view, animated: true)
            
        })
    }
    
}







