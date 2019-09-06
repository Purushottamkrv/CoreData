//
//  CoreaDataHelper.swift
//  CoreDataTest
//
//  Created by Purushottam on 07/09/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON
class CoreDataHelper{
    
    static let shaed = CoreDataHelper()
    
    func createData(response:JSON) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Categories", in: managedContext)!
        let arrayValue = response["categories"].arrayValue
        
        for i in arrayValue{
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(i["category_slug"].stringValue, forKey: "category_slug")
            user.setValue(i["bcategory_name"].stringValue, forKey: "bcategory_name")
            user.setValue(i["icon"].stringValue, forKey: "icon")

            }
        
        do {
            try managedContext.save()
        }catch{
            print("failed saving")
        }
        
    }
}
