//
//  InstructionsViewController.swift
//  myFridge
//
//  Created by Kyle George on 5/16/21.
//

import UIKit

class InstructionsViewController: UIViewController {
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var nextStepTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var stepTextView: UITextView!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var undoLastButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var postImage: UIImage?
    var recipeName: String = ""
    var recipeDescription: String = ""
    var glutenFree: Bool?
    var vegan: Bool?
    var nutFree: Bool?
    var difficulty: String = ""
    var duration: String = ""
    
    var stepNumber = 1
    var directionsList: Array<String> = Array()
//    var instructionsAdded = false
//    var ingredientsList: Array<String> = Array()
//    var ingredientsAdded = false
    
    //var newPostViewController: NewPostViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("HEREE name", recipeName)
        stepTextView.layer.cornerRadius = stepTextView.frame.size.width/15
        
        nextButton.layer.cornerRadius = nextButton.frame.size.width/6.5
        nextButton.layer.borderColor = UIColor.systemOrange.cgColor
        nextButton.layer.borderWidth = 2.5
        
        clearAllButton.layer.cornerRadius = clearAllButton.frame.size.width/6.5
        clearAllButton.layer.borderColor = UIColor.systemGreen.cgColor
        clearAllButton.layer.borderWidth = 1
        
        undoLastButton.layer.cornerRadius = undoLastButton.frame.size.width/6.5
        undoLastButton.layer.borderColor = UIColor.systemGreen.cgColor
        undoLastButton.layer.borderWidth = 1
        
        addButton.layer.cornerRadius = addButton.frame.size.width/6.5
        addButton.layer.borderColor = UIColor.systemGreen.cgColor
        addButton.layer.borderWidth = 1.5
        
        //print("HERE ingredientsList", ingredientsList)
        
        //print(directionsList)
        
        if directionsList.count != 0{
            var i = 1
            for step in directionsList{
                if i == 1{
                    stepTextView.insertText(String(i) + ". " + step)
                }else{
                    stepTextView.insertText("\n")
                    stepTextView.insertText(String(i) + ". " + step)
                }
                i += 1
            }
        }
        
        stepNumber = 1

        // Do any additional setup after loading the view.
        
        //print(getDirectionsList())
        
//        let vc = NewPostViewController(nibName: "NewPostViewController", bundle: nil)
//        vc.instructionsViewController = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        nextStepTextField.resignFirstResponder()
    }
    
//    func setDirectionsList(list: Array<String>){
//        print("SET")
//        directionsList = list
//        print(directionsList)
//    }
//
//    func getDirectionsList() -> Array<String>{
//        print("GET")
//        print(directionsList)
//        return directionsList
//    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        directionsList.append(nextStepTextField.text!)
        if stepNumber == 1{
            stepTextView.insertText(String(stepNumber) + ". " + nextStepTextField.text!)
        }else{
            stepTextView.insertText("\n")
            stepTextView.insertText(String(stepNumber) + ". " + nextStepTextField.text!)
        }
        nextStepTextField.text?.removeAll()
        stepNumber += 1
        nextStepTextField.placeholder = "Add Step " + String(stepNumber)
    }
    
    @IBAction func onUndoLastButton(_ sender: Any) {
        //delete the last direction added to the textView and put it on the textField
        let lastStep = directionsList.removeLast()
        stepNumber -= 1
        stepTextView.text = nil
        var i = 1
        for step in directionsList{
            if i == 1{
                stepTextView.insertText(String(i) + ". " + step)
            }else{
                stepTextView.insertText("\n")
                stepTextView.insertText(String(i) + ". " + step)
            }
            i += 1
        }
        nextStepTextField.text = lastStep
    }
    
    @IBAction func onClearAllButton(_ sender: Any) {
        //remove all of the directions
        //basically reset the view
        directionsList.removeAll()
        stepTextView.text = nil
        stepNumber = 1
        nextStepTextField.placeholder = "Add Step " + String(stepNumber)
    }
    
    @IBAction func onNextButton(_ sender: Any) {
        if directionsList.count != 0{
            performSegue(withIdentifier: "ingredientsSegue", sender: nextButton)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as? UINavigationController
        let ingredientsViewController = navigation?.topViewController as? IngredientPostViewController
        
        ingredientsViewController?.postImage = self.postImage
        ingredientsViewController?.recipeName = self.recipeName
        ingredientsViewController?.recipeDescription = self.recipeDescription
        ingredientsViewController?.glutenFree = self.glutenFree
        ingredientsViewController?.vegan = self.vegan
        ingredientsViewController?.nutFree = self.nutFree
        ingredientsViewController?.difficulty = self.difficulty
        ingredientsViewController?.duration = self.duration
        ingredientsViewController?.directionsList = self.directionsList
    }
    
//    @IBAction func onFinishButton(_ sender: Any) {
//        //push the directionsList to the main post view controller
//        
//        //print("DIRECTIONS LIST", directionsList)
//        
//        //setDirectionsList(list: directionsList)
//        
//        //newPostViewController?.setDirectionsList(list: directionsList)
//        
////        _ = navigationController?.popToRootViewController(animated: true)
////        _ = navigationController?.popViewController(animated: true)
////        dismiss(animated: true) {
////            self.newPostViewController?.setDirectionsList(list: self.directionsList)
////        }
//        
////        func prepare(for segue: UIStoryboardSegue, sender: UIButton){
////            let newPostViewController = segue.destination as! NewPostViewController
////            newPostViewController.directionsList = self.directionsList
////        }
//        
//        //performSegue(withIdentifier: "instructionsSegue", sender: finishButton)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//
////        let newPostViewController = segue.destination as! NewPostViewController
////        newPostViewController.directionsList = directionsList
////        newPostViewController.instructionsAdded = true
////        newPostViewController.ingredientsAdded = ingredientsAdded
////        newPostViewController.ingredientsList = ingredientsList
//
////        let navigation = segue.destination as! UINavigationController
////        let newPostViewController = navigation.topViewController as! NewPostViewController
////        newPostViewController.instructionsAdded = true
////        newPostViewController.directionsList = directionsList
////        if ingredientsList.count != 0{
////            newPostViewController.ingredientsAdded = true
////            newPostViewController.ingredientsList = ingredientsList
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
