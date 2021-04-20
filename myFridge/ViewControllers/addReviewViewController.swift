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
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        let review = PFObject(className: "Reviews")
        
        review["text"] = reviewTextField.text
        review["post"] = post
        review["author"] = PFUser.current()
        
        post.add(review, forKey: "reviews")
        
        post.saveInBackground{ (success, error) in
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
