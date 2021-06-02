//
//  finalPostViewController.swift
//  myFridge
//
//  Created by Kyle George on 5/30/21.
//

import UIKit
import Parse

class finalPostViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeNameTextView: UITextView!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var glutenFreeSwitch: UISwitch!
    @IBOutlet weak var glutenFreeLabel: UILabel!
    @IBOutlet weak var veganSwitch: UISwitch!
    @IBOutlet weak var veganLabel: UILabel!
    @IBOutlet weak var nutFreeSwitch: UISwitch!
    @IBOutlet weak var nutFreeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    var newPostImage: UIImage?
    var recipeName: String = ""
    var recipeDescription: String = ""
    var glutenFree: Bool?
    var vegan: Bool?
    var nutFree: Bool?
    var difficulty: String = ""
    var duration: String = ""
    var directionsList: Array<String> = Array()
    var measurementsList: Array<String> = Array()
    var ingredientsList: Array<String> = Array()
    
    var users = [PFObject]()
    var currentUser = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addKeyboardObserver()
        
        postButton.layer.cornerRadius = postButton.frame.size.width/6.5
        postButton.layer.borderColor = UIColor.systemOrange.cgColor
        postButton.layer.borderWidth = 2.5
        
        if newPostImage == nil{
            postImage.image = UIImage(systemName: "exclamationmark.triangle")
        }else{
            postImage.image = newPostImage
        }
        recipeNameTextView.text = recipeName
        recipeDescriptionTextView.text = recipeDescription
        if glutenFree == true{
            glutenFreeSwitch.setOn(true, animated: true)
        }
        if vegan == true{
            veganSwitch.setOn(true, animated: true)
        }
        if nutFree == true{
            nutFreeSwitch.setOn(true, animated: true)
        }
        difficultyTextField.text = difficulty + "/5"
        durationTextField.text = duration
        
        var i = 1
        for step in directionsList{
            if i == 1{
                instructionsTextView.insertText(String(i) + ". " + step)
            }else{
                instructionsTextView.insertText("\n")
                instructionsTextView.insertText(String(i) + ". " + step)
            }
            i += 1
        }
        
        var k = 1
        var position = 0
        for item in measurementsList{
            if k == 1{
                ingredientsTextView.insertText(String(k) + ". " + item + " " + ingredientsList[position])
            }else{
                ingredientsTextView.insertText("\n")
                ingredientsTextView.insertText(String(k) + ". " + item + " " + ingredientsList[position])
            }
            k += 1
            position += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        ingredientsTextView.resignFirstResponder()
        instructionsTextView.resignFirstResponder()
        difficultyTextField.resignFirstResponder()
        durationTextField.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["author"] = PFUser.current()
        post["recipeName"] = recipeNameTextView.text
        post["recipeDescription"] = recipeDescriptionTextView.text
        
        
        //Getting switch values and setting label values
        if glutenFreeSwitch.isOn{
            post["glutenFree"] = true as Bool
        }
        else{
            post["glutenFree"] = false as Bool
        }
//        glutenFreeSwitchLabel.text = "Gluten Free?"
        
        
        if veganSwitch.isOn{
            post["isVegan"] = true as Bool
        }
        else{
            post["isVegan"] = false as Bool
        }
//        veganSwitchLabel.text = "Vegan?"
        
        
        if nutFreeSwitch.isOn{
            post["nutFree"] = true as Bool
        }
        else{
            post["nutFree"] = false as Bool
        }
//        nutFreeSwitchLabel.text = "Nut Free?"
        
        
        
        post["difficulty"] = difficultyTextField.text
        post["cookingDuration"] = durationTextField.text
        
        post["directions"] = directionsList
        post["measurements"] = measurementsList
        post["ingredients"] = ingredientsList
        
        let imageData = postImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["postImage"] = file
        
        print("here")
        
        let query = PFQuery(className: "User")
        
        query.includeKey("username")
        
        query.limit = 20
        query.findObjectsInBackground { [self] (users, error) in
            if users != nil{
                
                //userPosts.removeAll()
                self.users = users!
                print(self.users)
                for user in self.users{
                    if (user["objectId"] as AnyObject).objectId == currentUser?.objectId{
                        print("here")
                        user.add(post, forKey: "postsByUser")
                        dismiss(animated: true, completion: nil)
                    }else{
                        print("not the current user")
                    }
                }
            }
        }

        
        post.saveInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "confirmationSegue", sender: nil)
                print("saved!")
            }
        }
        
        //user?.add(post, forKey: "postsByUser")
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
