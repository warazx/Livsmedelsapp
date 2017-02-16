//
//  Food.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation

class Food {
    let name : String
    let id : Int
    let value : Double
    
    init(name: String, id: Int = 0, value: Double = 0) {
        self.name = name
        self.id = id
        self.value = value
    }
}
