//
//  FoodDetailViewController.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var kcalValue: UILabel!
    @IBOutlet weak var proteinValue: UILabel!
    @IBOutlet weak var fatValue: UILabel!
    @IBOutlet weak var kolhydraterValue: UILabel!
    
    var id : Int = 0
    let searchString = "http://www.matapi.se/foodstuff/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let foodUrl = URL(string: (searchString + "\(id)")) {
            if let foodData = try? Data(contentsOf: foodUrl) {
                let foodJson = JSON(data: foodData)
                
                foodName.text = foodJson["name"].stringValue
                let foodNutrients = foodJson["nutrientValues"]
                kcalValue.text = String(foodNutrients["energyKcal"].doubleValue)
                proteinValue.text = String(foodNutrients["protein"].doubleValue)
                fatValue.text = String(foodNutrients["fat"].doubleValue)
                kolhydraterValue.text = String(foodNutrients["carbohydrates"].doubleValue)
            }
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
