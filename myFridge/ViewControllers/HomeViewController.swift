//
//  HomeViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/30/21.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        
        cell.recipeNameLabel.text = post["recipeName"] as? String
        cell.recipeSummaryLabel.text = post["recipeSummary"] as? String
        cell.reviewsLabel.text = "Reviews:"
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.imageFood.af_setImage(withURL: url)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
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
