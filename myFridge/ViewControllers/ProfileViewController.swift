//
//  ProfileViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 3/30/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var usernameLabel: UILabel!
        
    var currentUser = PFUser.current()
    var posts = [PFObject]()

    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        //setting the profile picture design.
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.systemOrange.cgColor
        profileImageView.layer.borderWidth = 3.5
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        
      }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if currentUser != nil {
          // Do stuff with the user
            print(currentUser as Any)
            usernameLabel.text = currentUser!["username"] as? String
            if currentUser?["profileImage"] != nil{
                let imageFile = currentUser?["profileImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                profileImageView.af_setImage(withURL: url)
            }
        } else {
          // No user found
            print("None")
        }
        
        
        let query = PFQuery(className: "Posts")
        
        query.includeKey("author")
        
        query.limit = 20
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                
                self.posts = posts!
                
                self.userTableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userPostCell") as! userPostCell
        if (posts[indexPath.row]["author"] as AnyObject).username! == currentUser?.username{
            let post = posts[indexPath.row]
            print(post)
            
            cell.recipeNameLabel.text = post["recipeName"] as? String
            cell.summaryLabel.text = post["recipeSummary"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.userPostImageView.af_setImage(withURL: url)

        }
        return cell
    }
    
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
        
        profileImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
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
}
