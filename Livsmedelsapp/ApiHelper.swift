//
//  ApiHelper.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-20.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiHelper {
    
    func getFoodsFrom(search: String, onDataFunc: @escaping ([Food]) -> Void) {
        var apiFoods : [Food] = []
        let originURL = "http://www.matapi.se/foodstuff?query=\(search)"
        
        if let url = URL(string: originURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (data : Data?, response : URLResponse?, error : Error?) in
                if let unwrappedData = data {
                    let jsonData = JSON(data: unwrappedData)
                    
                    for food in jsonData.arrayValue {
                        let name = food["name"].stringValue
                        let id = food["number"].intValue
                        apiFoods.append(Food(name: name, id: id))
                        NSLog("Added \(name) #\(apiFoods.count)")
                    }
                }
                onDataFunc(apiFoods)
            }
            task.resume()
        }
    }
}
