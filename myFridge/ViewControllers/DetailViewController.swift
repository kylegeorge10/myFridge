//
//  DetailViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/30/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundRecipeImage: UIImageView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var fullRecipeLabel: UILabel!
    
    var recipe: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        recipeNameLabel.text = recipe["recipeName"] as? String
        recipeNameLabel.sizeToFit()
        fullRecipeLabel.text = recipe["recipe"] as? String
        fullRecipeLabel.sizeToFit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
