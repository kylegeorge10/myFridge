//
//  SignUpFormViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 5/30/21.
//

import UIKit
import Parse
import AlamofireImage

class SignUpFormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var matchPasswordErrorLabel: UILabel!
    @IBOutlet weak var onCompleteButton: UIButton!
    
    var currentUser = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // designs
        bioTextView.layer.cornerRadius = bioTextView.frame.size.width / 15
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2.5
        onCompleteButton.layer.cornerRadius = onCompleteButton.frame.size.width / 9
        onCompleteButton.layer.borderColor = UIColor.systemGreen.cgColor
        onCompleteButton.layer.borderWidth = 3.5
        
    }
    
    @IBAction func onComplete(_ sender: Any) {
        let user = PFUser()
        
        user["first_name"] = firstNameTextField.text
        user["last_name"] = lastNameTextField.text
        user["bio"] = bioTextView.text
        user.email = userNameTextField.text
        user.username = userNameTextField.text
        
        //check if the new password and confirm passwords are matching.
        if newPasswordTextField.text != confirmPasswordTextField.text{
            print("Oops! Passwords did not match.")
            matchPasswordErrorLabel.text = "Oops! Passwords did not match."
        }else{
            user.password = newPasswordTextField.text
        }
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        
        
    }
    
    
    
    
    @IBAction func onCameraButton(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
            picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.view.tintColor = UIColor.systemGreen
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {action in picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profileImageView.image = scaledImage
        
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
        
        let profileImageData = profileImageView.image!.pngData()
        let file = PFFileObject(name: "profileImage.png", data: profileImageData!)
        
        currentUser?["profileImage"] = file
        
        currentUser?.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
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

    
    @IBAction func onBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
