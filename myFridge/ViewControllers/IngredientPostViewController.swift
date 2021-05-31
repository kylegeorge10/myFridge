//
//  IngredientPostViewController.swift
//  myFridge
//
//  Created by Kyle George on 5/14/21.
//

import UIKit

class IngredientPostViewController: UIViewController {
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var measurementTextField: UITextField!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ingredientListTextView: UITextView!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var undoLastButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var measurementNumber = 1
    var ingredientNumber = 1
    var measurementsList: Array<String> = Array()
    var ingredientsList: Array<String> = Array()
    
    var postImage: UIImage?
    var recipeName: String = ""
    var recipeDescription: String = ""
    var glutenFree: Bool?
    var vegan: Bool?
    var nutFree: Bool?
    var difficulty: String = ""
    var duration: String = ""
    var directionsList: Array<String> = Array()
    
//    var ingredientsAdded = false
//    var directionsList: Array<String> = Array()
//    var instructionsAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HERE directionsList", directionsList)
        
        measurementNumber = 1
        ingredientNumber = 1

        // Do any additional setup after loading the view.
    }
    
    func getMeasurementList() -> Array<String>{
        return measurementsList
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        measurementsList.append(measurementTextField.text!)
        ingredientsList.append(ingredientTextField.text!)
        
        if measurementNumber == 1{
            ingredientListTextView.insertText(String(String(measurementNumber) + ". " + measurementTextField.text!) + " " + ingredientTextField.text!)
        }else{
            ingredientListTextView.insertText("\n")
            ingredientListTextView.insertText(String(measurementNumber) + ". " + String(measurementTextField.text!) + " " + String(ingredientTextField.text!))
        }
        measurementTextField.text?.removeAll()
        ingredientTextField.text?.removeAll()
        measurementNumber += 1
        ingredientNumber += 1
        measurementTextField.placeholder = "Add Measurement " + String(measurementNumber)
        ingredientTextField.placeholder = "Add Ingredient " + String(ingredientNumber)
    }
    
    @IBAction func onClearAllButton(_ sender: Any) {
        measurementsList.removeAll()
        ingredientsList.removeAll()
        ingredientListTextView.text = nil
        ingredientNumber = 1
        measurementNumber = 1
        measurementTextField.placeholder = "Add Measurement " + String(measurementNumber)
        ingredientTextField.placeholder = "Add Ingredient " + String(ingredientNumber)
    }
    
    @IBAction func onUndoLastButton(_ sender: Any) {
        //delete the last ingredient and measurement added and put it back in the proper text field
        let lastIngredient = ingredientsList.removeLast()
        let lastMeasurement = measurementsList.removeLast()
        measurementNumber -= 1
        ingredientNumber -= 1
        ingredientListTextView.text = nil
        var k = 1
        var position = 0
        for item in measurementsList{
            if k == 1{
                ingredientListTextView.insertText(String(k) + ". " + item + " " + ingredientsList[position])
            }else{
                ingredientListTextView.insertText("\n")
                ingredientListTextView.insertText(String(k) + ". " + item + " " + ingredientsList[position])
            }
            k += 1
            position += 1
        }
        measurementTextField.text = lastMeasurement
        ingredientTextField.text = lastIngredient
    }
    
    @IBAction func onNextButton(_ sender: Any) {
        if measurementsList.count != 0{
            if ingredientsList.count != 0{
                performSegue(withIdentifier: "postSegue", sender: nextButton)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as? UINavigationController
        let finalPostViewController = navigation?.topViewController as? finalPostViewController
        
        finalPostViewController?.newPostImage = self.postImage
        finalPostViewController?.recipeName = self.recipeName
        finalPostViewController?.recipeDescription = self.recipeDescription
        finalPostViewController?.glutenFree = self.glutenFree
        finalPostViewController?.vegan = self.vegan
        finalPostViewController?.nutFree = self.nutFree
        finalPostViewController?.difficulty = self.difficulty
        finalPostViewController?.duration = self.duration
        finalPostViewController?.directionsList = self.directionsList
        finalPostViewController?.measurementsList = self.measurementsList
        finalPostViewController?.ingredientsList = self.ingredientsList
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let newPostViewController = segue.destination as! NewPostViewController
//        //newPostViewController.ingredientsAdded = true
//        newPostViewController.ingredientsList = ingredientsList
//        newPostViewController.directionsList = directionsList
//        //newPostViewController.instructionsAdded = instructionsAdded
//
////        let navigation = segue.destination as! UINavigationController
////        let newPostViewController = navigation.topViewController as! NewPostViewController
////        newPostViewController.ingredientsAdded = true
////        newPostViewController.ingredientsList = ingredientsList
////        if directionsList.count != 0{
////            newPostViewController.instructionsAdded = true
////            newPostViewController.directionsList = directionsList
////        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
