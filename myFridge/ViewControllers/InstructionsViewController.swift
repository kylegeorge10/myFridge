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
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var undoLastButton: UIButton!
    
    var stepNumber = 1
    var directionsList: Array<String> = Array()
    var instructionsAdded = false
    var ingredientsList: Array<String> = Array()
    var ingredientsAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HERE", ingredientsList)
        
        stepNumber = 1

        // Do any additional setup after loading the view.
    }
    
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
    
    @IBAction func onFinishButton(_ sender: Any) {
        //push the directionsList to the main post view controller
        
        performSegue(withIdentifier: "instructionsSegue", sender: finishButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigation = segue.destination as! UINavigationController
        let newPostViewController = navigation.topViewController as! NewPostViewController
        newPostViewController.instructionsAdded = true
        newPostViewController.directionsList = directionsList
        if ingredientsList.count != 0{
            newPostViewController.ingredientsAdded = true
            newPostViewController.ingredientsList = ingredientsList
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
