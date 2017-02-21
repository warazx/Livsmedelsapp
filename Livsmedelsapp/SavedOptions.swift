//
//  SavedOptions.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-21.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation

class SavedOptions {
    private let favorites = "favorites"
    
    func saveToFavorites(id: Int) {
        let userDefaults = UserDefaults.standard
        if var favArray : [Int] = userDefaults.array(forKey: favorites) as! [Int]? {
            favArray.append(id)
            userDefaults.removeObject(forKey: favorites)
            userDefaults.set(favArray, forKey: favorites)
            NSLog("Saved \(id) to favorites")
            //currentFavorites()
        } else {
            let arrayOfFavorites : [Int] = [ id ]
            userDefaults.set(arrayOfFavorites, forKey: favorites)
            NSLog("Created favorites save")
            NSLog("Saved \(id) to favorites")
            //currentFavorites()
        }
    }
    
    func removeFromFavorites(id: Int) {
        let userDefaults = UserDefaults.standard
        if var favArray = userDefaults.array(forKey: favorites) as! [Int]? {
            if let favToRemove = favArray.index(of: id) {
                favArray.remove(at: favToRemove)
                userDefaults.set(favArray, forKey: favorites)
                NSLog("Removed \(id) from favorites")
                //currentFavorites()
            }
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        let userDefaults = UserDefaults.standard
        if let favArray = userDefaults.array(forKey: favorites) as! [Int]? {
            return favArray.contains(id)
        }
        return false
    }
    
    /*func currentFavorites() {
        let userDefaults = UserDefaults.standard
        print("Current favorites:")
        if let favArray = userDefaults.array(forKey: favorites) {
            for n in favArray {
                print(n)
            }
        }
    }*/
}
