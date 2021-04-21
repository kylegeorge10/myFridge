//
//  PostViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/31/21.
//

import UIKit
import Parse
import AlamofireImage

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeSummaryTextField: UITextField!
    @IBOutlet weak var recipeFullTextField: UITextField!
    @IBOutlet weak var difficultyRatingTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var cookingDurationTextField: UITextField!
    @IBOutlet weak var recipeDetailsLabel: UILabel!
    @IBOutlet weak var glutenFreeSwitch: UISwitch!
    @IBOutlet weak var glutenFreeSwitchLabel: UILabel!
    @IBOutlet weak var veganSwitch: UISwitch!
    @IBOutlet weak var veganSwitchLabel: UILabel!
    @IBOutlet weak var nutFreeSwitch: UISwitch!
    @IBOutlet weak var nutFreeSwitchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when not in use
        recipeNameTextField.resignFirstResponder()
        recipeSummaryTextField.resignFirstResponder()
        recipeFullTextField.resignFirstResponder()
        difficultyRatingTextField.resignFirstResponder()
        ingredientsTextField.resignFirstResponder()
        cookingDurationTextField.resignFirstResponder()
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["author"] = PFUser.current()
        recipeDetailsLabel.text = "Recipe Details:"
        post["recipeName"] = recipeNameTextField.text!
        post["recipeSummary"] = recipeSummaryTextField.text!
        post["recipeFull"] = recipeFullTextField.text!
        
        
        //Getting switch values and setting label values
        if glutenFreeSwitch.isOn{
            post["glutenFree"] = true as Bool
        }
        else{
            post["glutenFree"] = false as Bool
        }
        glutenFreeSwitchLabel.text = "Gluten Free?"
        
        
        if veganSwitch.isOn{
            post["isVegan"] = true as Bool
        }
        else{
            post["isVegan"] = false as Bool
        }
        veganSwitchLabel.text = "Vegan?"
        
        
        if nutFreeSwitch.isOn{
            post["nutFree"] = true as Bool
        }
        else{
            post["nutFree"] = false as Bool
        }
        nutFreeSwitchLabel.text = "Nut Free?"
        
        
        
        post["difficultyRating"] = difficultyRatingTextField.text!
        post["ingredients"] = ingredientsTextField.text!
        post["cookingDuration"] = cookingDurationTextField.text!
        
        let imageData = imagePost.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }
        }
    }
    
//    @IBAction func onCameraButton(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            picker.sourceType = .camera
//        }else{
//            picker.sourceType = .photoLibrary
//        }
//        present(picker, animated: true, completion: nil)
//    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imagePost.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
