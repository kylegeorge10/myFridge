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
    @IBOutlet weak var postNumLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    var currentUser = PFUser.current()
    
    var posts = [PFObject]()
    
    var userPosts = [PFObject]()
    
    
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
            
            usernameLabel.text = currentUser!["username"] as? String
            
            //checking for name
            if (currentUser!["fisrt_name"] != nil || currentUser!["last_name"] != nil){
                let fName = currentUser!["first_name"] as? String
                let lName = currentUser!["last_name"] as? String
                fullnameLabel.text = "\(fName!) \(lName!)"
            }else{
                fullnameLabel.text = "Full Name"
            }
            
            //checking for bio
            if (currentUser!["bio"] != nil) {
                bioLabel.text = currentUser!["bio"] as? String
                
            }else{
                bioLabel.text = "Bio"
            }
            
            //checking for the profile picture
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
        query.findObjectsInBackground { [self] (posts, error) in
            if posts != nil{
                
                userPosts.removeAll()
                self.posts = posts!
                for allPosts in self.posts{
                    if (allPosts["author"] as AnyObject).username == currentUser?.username{
                        print("true")
                        userPosts.append(allPosts)
                        print(userPosts)
                    }else{
                        print("not the current users post")
                    }
                }
                //print(userPosts)
                self.userTableView.reloadData()
                postNumLabel.text = String(userPosts.count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userPostCell") as! userPostCell
        
        print((posts[indexPath.row]["author"] as AnyObject).username! as Any)
        print(currentUser?.username as Any)
        
        for selectedPost in userPosts{
            if ((selectedPost["author"] as AnyObject).username! == currentUser?.username) {
                print("true")
                cell.recipeNameLabel.text = selectedPost["recipeName"] as? String
                cell.summaryLabel.text = selectedPost["recipeDescription"] as? String
                
                let theDate = selectedPost.createdAt
                //print(theDate as Any)
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateStyle = .long

                let fDate = formatter.string(from: theDate!)
                cell.dateLabel.text = fDate
                
                let imageFile = selectedPost["postImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                

                cell.userPostImageView.af_setImage(withURL: url)
                
                cell.userPostImageView.layer.cornerRadius = cell.userPostImageView.frame.size.height / 4.5
                cell.userPostImageView.clipsToBounds = true
                cell.userPostImageView.layer.borderColor = UIColor.systemGray.cgColor
                cell.userPostImageView.layer.borderWidth = 2.5
                
            }else{
                print("false")
            }
        }
        
//        if (posts[indexPath.row]["author"] as AnyObject).username! == currentUser?.username{
//            let post = userPosts[indexPath.row]
//            cell.recipeNameLabel.text = post["recipeName"] as? String
//            print(post["recipeName"] as Any)
//            cell.summaryLabel.text = post["recipeSummary"] as? String
//
//            let theDate = post.createdAt
//            //print(theDate as Any)
//            let formatter = DateFormatter()
//            formatter.locale = Locale(identifier: "en_US")
//            formatter.dateStyle = .long
//
//            let fDate = formatter.string(from: theDate!)
//            cell.dateLabel.text = fDate
//
//            let imageFile = post["postImage"] as! PFFileObject
//            let urlString = imageFile.url!
//            let url = URL(string: urlString)!
//
//
//            cell.userPostImageView.af_setImage(withURL: url)
//
//
//            cell.userPostImageView.layer.cornerRadius = cell.userPostImageView.frame.size.height / 4.5
//            cell.userPostImageView.clipsToBounds = true
//            cell.userPostImageView.layer.borderColor = UIColor.systemGray.cgColor
//            cell.userPostImageView.layer.borderWidth = 2.5
//
//        }
    
        return cell
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
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
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
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
}
