//
//  addReviewViewController.swift
//  myFridge
//
//  Created by Kyle George on 4/20/21.
//

import UIKit
import Parse

class addReviewViewController: UIViewController {
    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    var post: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when not in use
        reviewTextField.resignFirstResponder()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        print(post)
        let review = PFObject(className: "Reviews")
        
        print("HERE 1")
        
        review["text"] = reviewTextField.text
        print("HERE 2")
        review["post"] = post
        print("HERE 3")
        review["author"] = PFUser.current()
        print("HERE 4")
        
        post.add(review, forKey: "reviews")
        print("HERE 5")
        
        post.saveInBackground{ (success, error) in
            print("HERE 6")
            if success{
                print("review saved")
            }
            else{
                print("Error saving review")
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
