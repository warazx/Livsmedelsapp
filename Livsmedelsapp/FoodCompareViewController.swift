//
//  FoodCompareViewController.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-03-03.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

class FoodCompareViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var pickerOne: UIPickerView!
    @IBOutlet weak var pickerTwo: UIPickerView!
    @IBOutlet weak var foodOneLabel: UILabel!
    @IBOutlet weak var foodTwoLabel: UILabel!
    @IBOutlet weak var foodDiagram: FoodDiagram!
    var foods : [Food] = []
    let apiHelper = ApiHelper()
    let savedOptions = SavedOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerOne.dataSource = self
        pickerTwo.dataSource = self
        pickerOne.delegate = self
        pickerTwo.delegate = self

        let favoritesArray = savedOptions.getAllFavorites()
        for favoriteID in favoritesArray {
            apiHelper.getFoodFromId(favoriteID) {
                self.foods.append($0)
                self.pickerOne.reloadAllComponents()
                self.pickerTwo.reloadAllComponents()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foods.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foods[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerOne {
            foodDiagram.foodOne = foods[row]
            foodOneLabel.text = foods[row].name
        } else {
            foodDiagram.foodTwo = foods[row]
            foodTwoLabel.text = foods[row].name
        }
        foodDiagram.setNeedsDisplay()
    }
}
