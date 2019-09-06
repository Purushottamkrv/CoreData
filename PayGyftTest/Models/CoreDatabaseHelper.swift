//
//  CoreDatabaseHelper.swift
//  PayGyftTest
//
//  Created by Purushottam on 25/08/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData
// app delegate, contecxt, entity



class CoreDBhelper {
    
    static let shared = CoreDBhelper()
    private init(){}
    
    func saveCategoryDataToCoreDB(object : JSON) {
        let appdelegate  = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CategoryList", in: context)
        
        let categoriesArray = object["categories"].arrayValue
        for object in categoriesArray {
            
            print("object is",object)
            
            let newCategory = NSManagedObject(entity: entity!, insertInto: context)
            newCategory.setValue(object["category_slug"].stringValue, forKey: "category_slug")
            newCategory.setValue(object["bcategory_name"].stringValue, forKey: "bcategory_name")
            newCategory.setValue(object["icon"].stringValue, forKey: "icon")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    func getDataFromDb(listName : String) -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: listName)
        let context = appDelegate.persistentContainer.viewContext
        var result = [NSManagedObject]()
        request.returnsObjectsAsFaults = false
        do {
            result = try context.fetch(request) as! [NSManagedObject]
            return result
        } catch {
            print("Failed")
        }
        return result
    }
    
    func convertDBDataToDBUser(object : [NSManagedObject]) -> [CategoryListModelCategory] {
        
        var tempData = [CategoryListModelCategory]()
        for object in object {
            let categorySlugName = object.value(forKey: "category_slug") as? String ?? ""
            let bCategoryName = object.value(forKey: "bcategory_name") as? String ?? ""
            let icon = object.value(forKey: "icon") as? String ?? ""
            let singleDictionary:JSON = ["category_slug":categorySlugName,"bcategory_name":bCategoryName,"icon":icon]
            let singleDiCValue = CategoryListModelCategory.init(fromJson: singleDictionary)
            tempData.append(singleDiCValue)
        }
        return tempData
    }
    
    
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    
}


class CoreDBCategoryDetailhelper {
    
    static let shared = CoreDBCategoryDetailhelper()
    private init(){}
    
    func saveCategoryDataToCoreDB(object : JSON) {
        let appdelegate  = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CategoryDetail", in: context)
        let dataArray = object["data"].arrayValue
        
        for object in dataArray {
            print("object in detail ",object)
            let newCategory = NSManagedObject(entity: entity!, insertInto: context)
            newCategory.setValue(object["category_slug"].stringValue, forKey: "category_slug")
            newCategory.setValue(object["logo"].stringValue, forKey: "logo")
            newCategory.setValue(object["store_name"].stringValue, forKey: "store_name")
            newCategory.setValue(object["offer"].stringValue, forKey: "offer")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    func getDataFromDb(listName : String) -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: listName)
        let context = appDelegate.persistentContainer.viewContext
        
        var result = [NSManagedObject]()
        request.returnsObjectsAsFaults = false
        
        do {
            result = try context.fetch(request) as! [NSManagedObject]
            
            return result
            
        } catch {
            
            print("Failed")
        }
        return result
    }
    
    func convertDBDataToDBUser(object : [NSManagedObject]) -> [CategoryDetailData] {
        var tempData = [CategoryDetailData]()
        for object in object {
            let CategorySlag = object.value(forKey: "category_slug") as? String ?? ""
            let logo = object.value(forKey: "logo") as? String ?? ""
            let StoreName = object.value(forKey: "store_name") as? String ?? ""
            let offer = object.value(forKey: "offer") as? String ?? ""
            
            let singleDictionary:JSON = ["category_slug":CategorySlag,"logo":logo,"store_name":StoreName,"offer":offer]
            let singleDiCValue = CategoryDetailData.init(fromJson: singleDictionary)
            tempData.append(singleDiCValue)
        }
        return tempData
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    
}


class CoreDBCategoryDetailWholeDatahelper {
    
    static let shared = CoreDBCategoryDetailWholeDatahelper()
    private init(){}
    
    func saveCategoryDataToCoreDB(object : JSON) {
        let appdelegate  = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CategoryListDetailData", in: context)
        
        let dataArray = object["data"].arrayValue

            print("object in detail ",object)
            let newCategory = NSManagedObject(entity: entity!, insertInto: context)
            newCategory.setValue(dataArray, forKey: "categoryListData")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            
        }
    }
    
    func getDataFromDb(listName : String) -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: listName)
        let context = appDelegate.persistentContainer.viewContext
        
        var result = [NSManagedObject]()
        request.returnsObjectsAsFaults = false
        
        do {
            result = try context.fetch(request) as! [NSManagedObject]
            return result
            
        } catch {
            
            print("Failed")
        }
        return result
    }
//    
//    func convertDBDataToDBUser(object : [NSManagedObject]) -> [[CategoryDetailData]] {
//        var tempData = [[CategoryDetailData]]()
//        for object in object {
//            let CategorySlag = object.value(forKey: "category_slug") as? String ?? ""
//            let logo = object.value(forKey: "logo") as? String ?? ""
//            let StoreName = object.value(forKey: "store_name") as? String ?? ""
//            let offer = object.value(forKey: "offer") as? String ?? ""
////
////            let singleDictionary:JSON = ["category_slug":CategorySlag,"logo":logo,"store_name":StoreName,"offer":offer]
////            let singleDiCValue = CategoryDetailData.init(fromJson: singleDictionary)
//            //empData.append(object)
//        }
//        return tempData
//    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    
}
