//
//  DetailViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/30/21.
//

import UIKit
import Parse
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundRecipeImage: UIImageView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var fullRecipeLabel: UILabel!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        recipeNameLabel.text = post["recipeName"] as? String
        recipeNameLabel.sizeToFit()
        fullRecipeLabel.text = post["recipeFull"] as? String
        fullRecipeLabel.sizeToFit()
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        foodImage.af_setImage(withURL: url)
 
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
