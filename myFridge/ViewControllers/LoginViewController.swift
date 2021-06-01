//
//  LoginViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/29/21.
//

import UIKit
import Parse


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signInButton.layer.cornerRadius = signInButton.frame.size.width/5
        signUpButton.layer.cornerRadius = signUpButton.frame.size.width/9
        
//        self.usernameField.delegate = self
//        self.passwordField.delegate = self
    
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let nextTag = textField.tag + 1
//        let nextTF = textField.superview?.viewWithTag(nextTag) as UIResponder?
//        if nextTF != nil {
//            print("yes")
//            nextTF?.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//        }
//        return false
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Error: \(error?.localizedDescription)")
                self.errorLabel.text = " Please try again, \(error!.localizedDescription)"
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
//        let user = PFUser()
//        user.username = usernameField.text
//        user.password = passwordField.text
//
//        user.signUpInBackground { (success, error) in
//            if success{
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            } else{
//                print("Error: \(error?.localizedDescription)")
//            }
//        }
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
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
