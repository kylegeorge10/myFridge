//
//  finalPostViewController.swift
//  myFridge
//
//  Created by Kyle George on 5/30/21.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
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
