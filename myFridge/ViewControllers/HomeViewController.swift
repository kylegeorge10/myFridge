//
//  HomeViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/30/21.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as! HomeViewCell
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        cell.recipeNameLabel.text = post["recipeName"] as? String
        cell.recipeSummaryLabel.text = post["recipeSummary"] as? String
        
        if post["authorImage"] != nil{
            let imageProfileFile = post["authorImage"] as! PFFileObject
            let urlProfileString = imageProfileFile.url!
            let urlProfile = URL(string: urlProfileString)!
            
            cell.profileImage.af_setImage(withURL: urlProfile)
        }
        /*
        if (post["glutenFree"] as! Bool) == true{
            let glutenImage = UIImage(named: "gluten_black")
            cell.glutenFreeImage.image = glutenImage
        }
        
        if (post["isVegan"] as! Bool) == true{
            let veganImage = UIImage(named: "vegan_black")
            cell.veganImage.image = veganImage
        }
        
        if (post["nutFree"] as! Bool) == true{
            let nutFreeImage = UIImage(named: "nut_black")
            cell.peanutFreeImage.image = nutFreeImage
        }
        */
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.imageFood.af_setImage(withURL: url)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find the selected post
        if sender is UITableViewCell{
            print("hello")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let post = posts[indexPath.section]
            
            // Pass the selected post to the details view controller
            let detailsViewController = segue.destination as! DetailViewController
            detailsViewController.post = post
            
            tableView.deselectRow(at: indexPath,animated: true)
        }

    }
    
    @IBAction func onUsernameTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "userProfileSegue", sender: gestureRecognizer)
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
