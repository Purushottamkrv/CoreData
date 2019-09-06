//
//  NetworkService.swift
//  PayGyftTest
//
//  Created by Purushottam on 25/08/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Service{
    
        class func NetworkCall(apiUrl:String,header:HTTPHeaders,onCompletion:@escaping (JSON) -> Void,failure: @escaping(Error) -> Void)  {
        Alamofire.request(apiUrl, method: .post,encoding:JSONEncoding.prettyPrinted , headers: header).responseJSON{ response in
            switch response.result{
            case .success(let data):
                let getresponse = JSON(data)
                onCompletion(getresponse)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
}

