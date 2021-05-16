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
    
    var stepNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepNumber = 1

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        
        //textView.text = [textView.text stringByAppendingString:@"\n\n"]
        
        stepTextView.insertText(nextStepTextField.text!)
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
