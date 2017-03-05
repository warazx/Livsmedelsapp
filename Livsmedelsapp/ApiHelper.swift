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
                    }
                }
                onDataFunc(apiFoods)
            }
            task.resume()
        }
    }
    
    func getKcalForId(id: Int, onDataFunc: @escaping (Double) -> Void) {
        
        if let detailURL = URL(string: "http://www.matapi.se/foodstuff/\(id)?nutrient=energyKcal") {
            let detailRequest = URLRequest(url: detailURL)
            let detailTask = URLSession.shared.dataTask(with: detailRequest) {
                (data : Data?, response : URLResponse?, error : Error?) in
                if let detailUnwrappedData = data {
                    let detailJSONData = JSON(data: detailUnwrappedData)
                    
                    let detailDict = detailJSONData.dictionaryValue["nutrientValues"]
                    
                    if let kcal = detailDict?["energyKcal"].doubleValue {
                        onDataFunc(kcal)
                    }
                }
            }
            detailTask.resume()
        }
    }
    
    func getFoodFromId(_ id: Int, onDataFunc: @escaping (Food) -> Void) {
        let detailedFood = Food(name: "")
        
        if let detailURL = URL(string: "http://www.matapi.se/foodstuff/\(id)") {
            let detailRequest = URLRequest(url: detailURL)
            let detailTask = URLSession.shared.dataTask(with: detailRequest) {
                (data : Data?, response : URLResponse?, error : Error?) in
                if let detailUnwrappedData = data {
                    let detailJSONData = JSON(data: detailUnwrappedData)
                    
                    if let foodJSON = detailJSONData.dictionary {
                        detailedFood.id = Int(foodJSON["number"]!.doubleValue)
                        detailedFood.name = (foodJSON["name"]?.stringValue)!
                        let nutrientValues = foodJSON["nutrientValues"]?.dictionaryValue
                        detailedFood.calories = (nutrientValues?["energyKcal"]?.doubleValue)!
                        detailedFood.protein = (nutrientValues?["protein"]?.doubleValue)!
                        detailedFood.fat = (nutrientValues?["fat"]?.doubleValue)!
                        detailedFood.carbohydrates = (nutrientValues?["carbohydrates"]?.doubleValue)!
                    }
                }
                onDataFunc(detailedFood)
            }
            detailTask.resume()
        }
    }
}
