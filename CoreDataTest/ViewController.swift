//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Purushottam on 07/09/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Call()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.textLabel?.text = "prince"
        return cell
    }

    
    func Call(){
        Alamofire.request("https://paygyft.com/api/v1/user/store/search/popular", method: .post, encoding: JSONEncoding.prettyPrinted, headers: Headers.header).responseJSON{ response in
            print(response)
            switch response.result{
            case .success(let data):
                let data = JSON(data)
            
            case .failure(let error):
                print(error)
            
        }
    }
    
}



}




struct Headers{
    static let header:HTTPHeaders = [
        "usrtoken" : "74c14fa62349c91c67607d8382656c431eb8e0b6-084e0343a0486ff05530df6c705c8bb4",
        "lat" : "12.9716",
        "lng" : "77.5946"]
}
