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
    var detailedFood : Food = Food(name: "")
    let apiHelper = ApiHelper()
    let searchString = "http://www.matapi.se/foodstuff/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiHelper.getFoodFromId(id) {
            self.detailedFood = $0
            DispatchQueue.main.async(execute: {
                self.updateText()
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    func updateText() {
        foodName.text = detailedFood.name
        kcalValue.text = String(detailedFood.value)
        proteinValue.text = String(detailedFood.protein)
        fatValue.text = String(detailedFood.fat)
        kolhydraterValue.text = String(detailedFood.carbo)
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
