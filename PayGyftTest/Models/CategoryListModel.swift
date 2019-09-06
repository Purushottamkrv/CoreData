//
//  CategoryListModel.swift
//  PayGyftTest
//
//  Created by Purushottam on 25/08/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoryListModelRootClass : NSObject{
    
    var categories : [CategoryListModelCategory]!
    var currentLocation : String!
    var data : [CategoryListModelData]!
    var dataCount : Int!
    var nextPage : Bool!
    var status : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        categories = [CategoryListModelCategory]()
        let categoriesArray = json["categories"].arrayValue
        for categoriesJson in categoriesArray{
            let value = CategoryListModelCategory(fromJson: categoriesJson)
            categories.append(value)
        }
        currentLocation = json["current_location"].stringValue
        data = [CategoryListModelData]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = CategoryListModelData(fromJson: dataJson)
            data.append(value)
        }
        dataCount = json["data_count"].intValue
        nextPage = json["next_page"].boolValue
        status = json["status"].intValue
}
}

class CategoryListModelData : NSObject{
    
    var bcategoryName : String!
    var categoryId : String!
    var distance : String!
    var distanceVal : Float!
    var location : String!
    var logo : String!
    var logoName : String!
    var offer : String!
    var pay : Int!
    var rating : Int!
    var shopAndEarn : Int!
    var storeCode : String!
    var storeName : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        bcategoryName = json["bcategory_name"].stringValue
        categoryId = json["category_id"].stringValue
        distance = json["distance"].stringValue
        distanceVal = json["distance_val"].floatValue
        location = json["location"].stringValue
        logo = json["logo"].stringValue
        logoName = json["logo_name"].stringValue
        offer = json["offer"].stringValue
        pay = json["pay"].intValue
        rating = json["rating"].intValue
        shopAndEarn = json["shop_and_earn"].intValue
        storeCode = json["store_code"].stringValue
        storeName = json["store_name"].stringValue
}

}

class CategoryListModelCategory : NSObject{
    
    var bcategoryName : String!
    var categorySlug : String!
    var icon : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        bcategoryName = json["bcategory_name"].stringValue
        categorySlug = json["category_slug"].stringValue
        icon = json["icon"].stringValue
}
}
