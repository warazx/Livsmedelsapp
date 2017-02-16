//
//  FoodTableViewController.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodTableViewController: UITableViewController {
    
    var foods : [Food] = []
    var searchString : String = ""
    var matURLquery = "http://www.matapi.se/foodstuff?query="

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = searchString
        
        if let url = URL(string: (matURLquery + searchString)) {
            if let data = try? Data(contentsOf: url) {
                let jsonData = JSON(data: data)
                
                for food in jsonData.arrayValue {
                    let name = food["name"].stringValue
                    let id = food["id"].intValue
                    foods.append(Food(name: name, id: id, value: 0.0))
                }
                
            }
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FoodTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FoodTableViewCell

        cell.foodName.text = foods[indexPath.row].name
        cell.foodValue.text = String(foods[indexPath.row].value)

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DetailSegue", let destination = segue.destination as? FoodDetailViewController {
            if let cell = sender as? FoodTableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let food = foods[indexPath.row].name
                destination.name = food
            }
        }
        
    }
 

}
