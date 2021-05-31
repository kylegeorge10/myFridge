//
//  SignUpFormViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 5/30/21.
//

import UIKit

class SignUpFormViewController: UIViewController {

    @IBOutlet weak var bioTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bioTextView.layer.cornerRadius = bioTextView.frame.size.width / 7
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
