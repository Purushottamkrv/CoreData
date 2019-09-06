//
//  Url.swift
//  PayGyftTest
//
//  Created by Purushottam on 25/08/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import Foundation

struct AppUrl {
    private struct Domains {
        static let BaseUrl = "https://paygyft.com/api/v1/user/store/search"
    }
    private  struct EndUrl {
        static let categoryList = "/popular"

    }
    
    //private  static let BaseURL = Domain + Route
    
    static var CategoryListApiUrl: String {
        return Domains.BaseUrl  + EndUrl.categoryList
    }
}
