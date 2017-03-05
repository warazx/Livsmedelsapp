//
//  FoodDiagram.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-03-03.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

class FoodDiagram: UIView {
    
    var foodOne : Food = Food(name: "1")
    var foodTwo : Food = Food(name: "2")
    private var _lastColorRed = false
    
    private let maxStaples = 8
    
    override func draw(_ rect: CGRect) {
        var maxHeightForStaple : Double {
            get {
                return [foodOne.carbohydrates, foodOne.fat, foodOne
                    .protein, foodOne.nutritionScore, foodTwo.carbohydrates, foodTwo.fat, foodTwo.protein, foodTwo.nutritionScore].max()!
            }
        }
        let maxHeight = Double(rect.height)
        let maxWidth = Double(rect.width)
        let stapleWidth = maxWidth / Double(maxStaples)
        
        for staple in 0..<maxStaples {
            var height = 0.0
            switch staple {
            case 0: height = foodOne.carbohydrates
            case 1: height = foodTwo.carbohydrates
            case 2: height = foodOne.fat
            case 3: height = foodTwo.fat
            case 4: height = foodOne.protein
            case 5: height = foodTwo.protein
            case 6: height = foodOne.nutritionScore
            case 7: height = foodTwo.nutritionScore
            default: height = 0.0
            }
            
            drawStaple(xPos: Double(staple) * stapleWidth, yPos: maxHeight, width: stapleWidth, height: -Double(height / maxHeightForStaple) * maxHeight)
        }
    }
    
    func drawStaple(xPos: Double, yPos: Double, width: Double, height: Double) {
        
        let drect = CGRect(x: xPos, y: yPos, width: width, height: height)
        let bpath = UIBezierPath(rect: drect)
        if _lastColorRed {
            UIColor.blue.setFill()
        } else {
            UIColor.red.setFill()
        }
        _lastColorRed = !_lastColorRed
        
        bpath.fill()
    }
}
