//
//  FoodTableViewController.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var foods : [Food] = []
    let apiHelper = ApiHelper()
    var searchString : String = ""
    var searchResult : [Food] = []
    var searchController : UISearchController!
    var favoriteMode = false
    let savedOptions = SavedOptions()

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        self.title = searchString
        
        if !favoriteMode {
            apiHelper.getFoodsFrom(search: searchString) {
                self.foods = $0
                for food in self.foods {
                    self.apiHelper.getKcalForId(id: food.id) {
                        food.calories = $0
                        self.tableView.reloadData()
                    }
                }
                self.tableView.reloadData()
            }
        } else {
            let favoritesArray = savedOptions.getAllFavorites()
            for favoriteID in favoritesArray {
                apiHelper.getFoodFromId(favoriteID) {
                    self.foods.append($0)
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text?.lowercased() {
            searchResult = foods.filter { $0.name.lowercased().contains(text) }
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        return searchController.isActive && !(searchController.searchBar.text ?? "").isEmpty
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return foods.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FoodTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FoodTableViewCell
        
        if shouldUseSearchResult {
            cell.foodName.text = searchResult[indexPath.row].name
            cell.foodValue.text = String(searchResult[indexPath.row].calories)
        } else {
            cell.foodName.text = foods[indexPath.row].name
            cell.foodValue.text = String(foods[indexPath.row].calories)
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue", let destination = segue.destination as? FoodDetailViewController {
            if let cell = sender as? FoodTableViewCell, let indexPath = tableView.indexPath(for: cell) {

                var id : Int
                if shouldUseSearchResult {
                    id = searchResult[indexPath.row].id
                } else {
                    id = foods[indexPath.row].id
                }
            
                destination.id = id
            }
        }
    }
}
