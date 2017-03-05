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
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    var dynamicAnimator : UIDynamicAnimator!
    var collision : UICollisionBehavior!
    var snap : UISnapBehavior!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        animateOnLoad()
        welcomeLabelDynamics()
    }
    
    func welcomeLabelDynamics() {
        dynamicAnimator = UIDynamicAnimator(referenceView: topView)
        collision = UICollisionBehavior(items: [messageLabel])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
        snap = UISnapBehavior(item: messageLabel, snapTo: topView.center)
        snap.damping = 0.25
        dynamicAnimator.addBehavior(snap)
    }
    
    func animateOnLoad() {
        uiBox.center.y -= view.bounds.height
        UIView.animate(withDuration: 0.75) {
            self.uiBox.center.y += self.view.bounds.height
        }
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        snap.snapPoint = sender.location(in: topView)
        NSLog("i work")
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue", let destination = segue.destination as? FoodTableViewController {
            if let searchText = searchField.text {
                destination.searchString = searchText
                destination.favoriteMode = false
            }
        }
        if segue.identifier == "FavoriteSegue", let destination = segue.destination as? FoodTableViewController {
            destination.favoriteMode = true
        }
    }
}
