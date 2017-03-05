//
//  Food.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation

class Food {
    var name : String
    var id : Int
    var calories : Double
    var protein : Double = 0
    var fat : Double = 0
    var carbohydrates : Double = 0
    
    
    init(name: String, id: Int = 0, calories: Double = 0) {
        self.name = name
        self.id = id
        self.calories = calories
    }
    
    var nutritionScore: Double {
        get {
            return ((self.fat + self.carbohydrates + self.protein) / 3.0)
        }
    }
}
