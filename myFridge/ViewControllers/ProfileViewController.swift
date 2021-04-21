//
//  ProfileViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 3/30/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
        
    var currentUser = PFUser.current()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        if currentUser != nil {
          // Do stuff with the user
            print(currentUser as Any)
            usernameLabel.text = currentUser!["username"] as? String
        } else {
          // No user found
            print("None")
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
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
        
    }
}
