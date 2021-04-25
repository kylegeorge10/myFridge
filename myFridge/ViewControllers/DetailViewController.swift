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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var glutenFreeImage: UIImageView!
    @IBOutlet weak var veganImage: UIImageView!
    @IBOutlet weak var nutFreeImage: UIImageView!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet var usernameTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var recipeSummary: UITextView!
    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var fullRecipe: UITextView!
    
    var post: PFObject!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let user = post["author"] as! PFUser
        usernameLabel.text = user.username
        if user["profileImage"] != nil{
            let imageFile = user["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            profileImage.af_setImage(withURL: url)
        }
        
        recipeNameLabel.text = post["recipeName"] as? String
        recipeNameLabel.sizeToFit()
        
        recipeSummary.text = post["recipeSummary"] as? String
        recipeSummary.sizeToFit()
        
        fullRecipe.text = post["recipeFull"] as? String
        fullRecipe.sizeToFit()
        
        ingredientsList.text = post["ingredients"] as? String
        ingredientsList.sizeToFit()
        
        let gluten = ((post["glutenFree"]) as? Bool)
        if (gluten == true){
            
            let glutenImage = UIImage(named: "gluten_black")
            glutenFreeImage.image = glutenImage
        }
        else {
            let glutenImage = UIImage(named: "gluten_white")
            glutenFreeImage.image = glutenImage
        }
 
        
        let nutfree = ((post["nutFree"]) as? Bool)
        if (nutfree == true){
            
            let newNutFreeImage = UIImage(named: "nut_black")
            nutFreeImage.image = newNutFreeImage
        }
        else {
            let newNutFreeImage = UIImage(named: "nut_white")
            nutFreeImage.image = newNutFreeImage
        }
        
        
        let vegan = ((post["isVegan"]) as? Bool)
        if (vegan == true){
            
            let newVeganImage = UIImage(named: "vegan_black")
            veganImage.image = newVeganImage
        }
        else {
            let newVeganImage = UIImage(named: "vegan_white")
            veganImage.image = newVeganImage
        }
        
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        foodImage.af_setImage(withURL: url)
 
    }
    
    @IBAction func onReviewsButton(_ sender: Any) {
        //moving the view controller to the next controller
        performSegue(withIdentifier: "reviewsSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        let reviewsViewController = navigation.topViewController as! ReviewsViewController
        reviewsViewController.post = self.post
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
