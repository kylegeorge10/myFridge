//
//  NewPostViewController.swift
//  myFridge
//
//  Created by Kyle George on 5/14/21.
//

import UIKit
import Parse

class NewPostViewController: UIViewController {
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeNameTextView: UITextView!
    
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    
    @IBOutlet weak var cookingInstructionsButton: UIButton!
    
    @IBOutlet weak var glutenFreeSwitch: UISwitch!
    @IBOutlet weak var glutenFreeLabel: UILabel!
    @IBOutlet weak var veganSwitch: UISwitch!
    @IBOutlet weak var veganLabel: UILabel!
    @IBOutlet weak var nutFreeSwitch: UISwitch!
    @IBOutlet weak var nutFreeLabel: UILabel!
    
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var ingredientsListButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
    
    var instructionsAdded = false
    var ingredientsAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        let user = PFObject(className: "User")
        
        post["author"] = PFUser.current()
        
        post["recipeName"] = recipeNameTextView.text!
        post["recipeDescription"] = recipeDescriptionTextView.text!
        
        //pull recipe instrcutions from the recipe storyboard
        
        if glutenFreeSwitch.isOn{
            post["glutenFree"] = true as Bool
        }else{
            post["glutenFree"] = false as Bool
        }
        
        if veganSwitch.isOn{
            post["isVegan"] = true as Bool
        }else{
            post["isVegan"] = false as Bool
        }
        
        if nutFreeSwitch.isOn{
            post["nutFree"] = true as Bool
        }else{
            post["nutFree"] = false as Bool
        }
        
        post["difficulty"] = difficultyTextField.text!
        post["duration"] = durationTextField.text!
        
        //pull ingredients list from ingredients storyboard
        
        user.add(post, forKey: "postsByUser")
        
        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("post saved")
            }else{
                print(error!)
            }
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
