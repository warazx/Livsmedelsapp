//
//  MainViewController.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var uiBox: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateOnLoad()
        // Do any additional setup after loading the view.
    }
    
    func animateOnLoad() {
        uiBox.center.y -= view.bounds.height
        UIView.animate(withDuration: 0.75) {
            self.uiBox.center.y += self.view.bounds.height
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "SearchSegue" {
                if (searchField.text?.characters.count)! < 2 {
                    searchField.text = ""
                    searchField.placeholder = "Minst två tecken"
                    return false
                }
            }
        }
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SearchSegue", let destination = segue.destination as? FoodTableViewController {
            if let searchText = searchField.text {
                destination.searchString = searchText
                destination.favoriteMode = false
            }
        }
        if segue.identifier == "FavoriteSegue", let destination = segue.destination as? FoodTableViewController {
            destination.favoriteMode = true
        }
        if segue.identifier == "CompareSegue", let destination = segue.destination as? FoodTableViewController {
            destination.favoriteMode = true
        }
    }

}
