//
//  NewPostViewController.swift
//  myFridge
//
//  Created by Kyle George on 5/14/21.
//

import UIKit
import Parse

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeNameTextView: UITextView!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var glutenFreeSwitch: UISwitch!
    @IBOutlet weak var glutenFreeLabel: UILabel!
    @IBOutlet weak var veganSwitch: UISwitch!
    @IBOutlet weak var veganLabel: UILabel!
    @IBOutlet weak var nutFreeSwitch: UISwitch!
    @IBOutlet weak var nutFreeLabel: UILabel!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
//    var directionsList: Array<String> = Array()
//    var measurementsList: Array<String> = Array()
//    var ingredientsList: Array<String> = Array()
//    var instructionsAdded = false
//    var ingredientsAdded = false
    
    //var instructionsViewController: InstructionsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("HERE ingredientsAdded", ingredientsAdded)
//        print("HERE instructionsAdded", instructionsAdded)
        
//        if instructionsAdded == true{
//            instructionsCheckImage.tintColor = UIColor.green
//        }
//
//        if ingredientsAdded == true{
//            ingredientsCheckImage.tintColor = UIColor.green
//        }

        // Do any additional setup after loading the view.
        
//        let vc = InstructionsViewController(nibName: "InstructionsViewController", bundle: nil)
//        vc.newPostViewController = self
        
//        let vc = SecondaryViewController(nibName: "SecondaryViewController", bundle: nil)
//        vc.mainViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //print("GETTER", instructionsViewController?.directionsList)
        
        //print("HERE HERE HERE HERE", instructionsViewController?.getDirectionsList() ?? [])
//        print("HERE HERE HERE HERE", getDirectionsList())
//        print("HERE HERE HERE HERE", getMeasurementsList())
//        print("HERE HERE HERE HERE", getIngredientsList())
//
//        if getDirectionsList().count != 0{
//            instructionsCheckImage.tintColor = UIColor.green
//        }
//
//        if getIngredientsList().count != 0{
//            ingredientsCheckImage.tintColor = UIColor.green
//        }
    }
    
//    func setMeasurementList(list: Array<String>){
//        measurementsList = list
//    }
//
//    func getMeasurementsList() -> Array<String>{
//        return measurementsList
//    }
//
//    func setIngredientsList(list: Array<String>){
//        ingredientsList = list
//    }
//
//    func getIngredientsList() -> Array<String> {
//        return ingredientsList
//    }
//
//    func setDirectionsList(list: Array<String>){
//        print("SETTING DIRECTIONS LIST")
//        directionsList = list
//    }
//
//    func getDirectionsList() -> Array<String> {
//        return directionsList
//    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onNextButton(_ sender: Any) {
        
        let post = PFObject(className: "Posts")
        let user = PFObject(className: "User")
        
        let imageData = postImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
        
        
        
        if recipeNameTextView.text != nil{
            if recipeDescriptionTextView.text != nil{
                if difficultyTextField.text != nil{
                    if durationTextField.text != nil{
                        performSegue(withIdentifier: "instructionsSegue", sender: nextButton)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigation = segue.destination as? UINavigationController
        let instructionsViewController = navigation?.topViewController as? InstructionsViewController
        
        instructionsViewController?.recipeName = recipeNameTextView.text!
        instructionsViewController?.recipeDescription = recipeDescriptionTextView.text!
        if glutenFreeSwitch.isOn{
            instructionsViewController?.glutenFree = true
        }else{
            instructionsViewController?.glutenFree = false
        }
        if veganSwitch.isOn{
            instructionsViewController?.vegan = true
        }else{
            instructionsViewController?.vegan = false
        }
        if nutFreeSwitch.isOn{
            instructionsViewController?.nutFree = true
        }else{
            instructionsViewController?.nutFree = false
        }
        instructionsViewController?.difficulty = difficultyTextField.text!
        instructionsViewController?.duration = durationTextField.text!
        
    }
    
//    @IBAction func onPostButton(_ sender: Any) {
//        let post = PFObject(className: "Posts")
//        let user = PFObject(className: "User")
//        
//        post["author"] = PFUser.current()
//        
//        post["recipeName"] = recipeNameTextView.text!
//        post["recipeDescription"] = recipeDescriptionTextView.text!
//        
//        //pull recipe instrcutions from the recipe storyboard
//        
//        if glutenFreeSwitch.isOn{
//            post["glutenFree"] = true as Bool
//        }else{
//            post["glutenFree"] = false as Bool
//        }
//        
//        if veganSwitch.isOn{
//            post["isVegan"] = true as Bool
//        }else{
//            post["isVegan"] = false as Bool
//        }
//        
//        if nutFreeSwitch.isOn{
//            post["nutFree"] = true as Bool
//        }else{
//            post["nutFree"] = false as Bool
//        }
//        
//        post["difficulty"] = difficultyTextField.text!
//        post["duration"] = durationTextField.text!
//        
//        //pull ingredients list from ingredients storyboard
//        
//        user.add(post, forKey: "postsByUser")
//        
//        post.saveInBackground { (success, error) in
//            if success{
//                self.dismiss(animated: true, completion: nil)
//                print("post saved")
//            }else{
//                print(error!)
//            }
//        }
//    }
    
//    func prepare(for segue: UIStoryboardSegue, sender: UIButton) {
//        if sender == cookingInstructionsButton{
//            let instructionsViewController = segue.destination as! InstructionsViewController
//            instructionsViewController.ingredientsAdded = ingredientsAdded
//            instructionsViewController.ingredientsList = ingredientsList
//            instructionsViewController.directionsList = directionsList
//            instructionsViewController.ingredientsAdded = instructionsAdded
//        }else if sender == ingredientsListButton{
//            let ingredientsViewController = segue.destination as! IngredientPostViewController
//            ingredientsViewController.instructionsAdded = instructionsAdded
//            ingredientsViewController.directionsList = directionsList
//            ingredientsViewController.ingredientsList = ingredientsList
//            ingredientsViewController.ingredientsAdded = ingredientsAdded
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Uploading the image via an image picker.
    
    @IBAction func uploadImageButton(_ sender: UITapGestureRecognizer) {
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
        
        postImage.image = scaledImage
        
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }

}
