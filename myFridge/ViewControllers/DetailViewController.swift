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

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var fullRecipeLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var recipeSummary: UILabel!
    @IBOutlet weak var glutenFreeImage: UIImageView!
    @IBOutlet weak var veganImage: UIImageView!
    @IBOutlet weak var nutFreeImage: UIImageView!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet var usernameTapGesture: UITapGestureRecognizer!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let user = post["author"] as! PFUser
        usernameLabel.text = user.username
        
        recipeNameLabel.text = post["recipeName"] as? String
        recipeNameLabel.sizeToFit()
        
        recipeSummary.text = post["recipeSummary"] as? String
        recipeSummary.sizeToFit()
        
        fullRecipeLabel.text = post["recipeFull"] as? String
        fullRecipeLabel.sizeToFit()
        
        /*
        if (post["glutenFree"] as! Bool) == true{
            let glutenImage = UIImage(named: "gluten_black")
            glutenFreeImage.image = glutenImage
        }
        
        if (post["isVegan"] as! Bool) == true{
            let newVeganImage = UIImage(named: "vegan_black")
            veganImage.image = newVeganImage
        }
        
        if (post["nutFree"] as! Bool) == true{
            let newNutFreeImage = UIImage(named: "nut_black")
            nutFreeImage.image = newNutFreeImage
        */
 
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        foodImage.af_setImage(withURL: url)
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UILabel{
            print("hello")
        }
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
