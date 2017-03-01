//
//  FoodDetailViewController.swift
//  Livsmedelsapp
//
//  Created by Christian Karlsson on 2017-02-14.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var favoriteSwitch: UISwitch!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var kcalValue: UILabel!
    @IBOutlet weak var proteinValue: UILabel!
    @IBOutlet weak var fatValue: UILabel!
    @IBOutlet weak var kolhydraterValue: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nutritionScoreValue: UILabel!
    
    var id : Int = 0
    var detailedFood : Food = Food(name: "")
    let apiHelper = ApiHelper()
    let savedOptions = SavedOptions()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiHelper.getFoodFromId(id) {
            self.detailedFood = $0
            DispatchQueue.main.async(execute: {
                self.updateText()
                self.isFavorited()
            })
            self.loadImage()
        }
    }
    
    func loadImage() {
        if let image = UIImage(contentsOfFile: imagePath) {
            foodImage.image = image
        } else {
            NSLog("There is no image")
        }
    }
    
    @IBAction func takePicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            picker.sourceType = .savedPhotosAlbum
        } else {
            fatalError("No source type.")
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        if let data = UIImagePNGRepresentation(image) {
            do {
                let url = URL(fileURLWithPath: imagePath)
                try data.write(to: url)
            } catch let error {
                NSLog("Failed to save image, error: \(error)")
            }
        }
        
        foodImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    var imagePath : String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentDirectory = paths.first {
            let imageName = "imageId\(detailedFood.id)"
            return documentDirectory.appending(imageName)
        } else {
            fatalError("No documents directory")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteSwitch(_ sender: UISwitch) {
        if sender.isOn {
            savedOptions.saveToFavorites(id: detailedFood.id)
        } else {
            savedOptions.removeFromFavorites(id: detailedFood.id)
        }
    }
    
    func updateText() {
        foodName.text = detailedFood.name
        kcalValue.text = String(detailedFood.value)
        proteinValue.text = String(detailedFood.protein)
        fatValue.text = String(detailedFood.fat)
        kolhydraterValue.text = String(detailedFood.carbo)
        nutritionScoreValue.text = String(detailedFood.nutritionScore)
    }
    
    func isFavorited() {
        if savedOptions.isFavorite(id: detailedFood.id) {
            favoriteSwitch.setOn(true, animated: false)
        } else {
            favoriteSwitch.setOn(false, animated: false)
        }
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
