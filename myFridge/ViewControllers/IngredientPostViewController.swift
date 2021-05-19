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
    @IBOutlet weak var finishButton: UIButton!
    
    var measurementNumber = 1
    var ingredientNumber = 1
    var measurementsList: Array<String> = Array()
    var ingredientsList: Array<String> = Array()
    var ingredientsAdded = false
    var directionsList: Array<String> = Array()
    var instructionsAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        measurementNumber = 1
        ingredientNumber = 1

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        measurementsList.append(measurementTextField.text!)
        ingredientsList.append(ingredientTextField.text!)
        
        if measurementNumber == 1{
            ingredientListTextView.insertText(String(measurementTextField.text!) + " " + ingredientTextField.text!)
        }else{
            ingredientListTextView.insertText("\n")
            ingredientListTextView.insertText(String(measurementTextField.text!) + " " + String(ingredientTextField.text!))
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
    }
    
    @IBAction func onFinishButton(_ sender: Any) {
        performSegue(withIdentifier: "ingredientsSegue", sender: finishButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        let newPostViewController = navigation.topViewController as! NewPostViewController
        newPostViewController.ingredientsAdded = true
        newPostViewController.ingredientsList = ingredientsList
        if directionsList.count != 0{
            newPostViewController.instructionsAdded = true
            newPostViewController.directionsList = directionsList
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
