//
//  HomeViewController.swift
//  myFridge
//
//  Created by Kyle George on 3/30/21.
//

import UIKit
import Parse
import Lottie
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    var animationView: AnimationView?
    var refresh = true
    
    let feedRefresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimations()
        feedRefresh.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        tableView.refreshControl = feedRefresh
        
        // refresh control icon color
        feedRefresh.tintColor = UIColor.systemGreen
        
        // refresh control note attribute
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 15), NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
        let attributedTitle = NSAttributedString(string: "Fetching More Yummy Recipes!", attributes: attributes as [NSAttributedString.Key : Any])
        feedRefresh.attributedTitle = attributedTitle
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopAnimations), userInfo: nil, repeats: false)
        
    
        self.feedRefresh.endRefreshing()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //obatins the data from parse and sort with recent posts at top and older posts at the bottom.
        let query = PFQuery(className:"Posts").order(byDescending: "createdAt")
        query.includeKeys(["author", "reviews", "reviews.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
                self.feedRefresh.endRefreshing()
                
            }
        }
        //self.refreshControl.endRefreshing()
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
        cell.recipeSummaryLabel.text = post["recipeDescription"] as? String
        
        let theDate = post.createdAt
        //print(theDate as Any)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long

        let fDate = formatter.string(from: theDate!)
        cell.dateLabel.text = fDate
        
        
        if user["profileImage"] != nil{
            let imageFile = user["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.profileImage.af_setImage(withURL: url)
            //design of the profile picture
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 5
            cell.profileImage.clipsToBounds = true
            cell.profileImage.layer.borderColor = UIColor.systemOrange.cgColor
            cell.profileImage.layer.borderWidth = 1.5
            
        }
        
        
        if (post["glutenFree"] as! Bool) != false{
            let glutenImage = UIImage(named: "gluten_black")
            cell.glutenFreeImage.image = glutenImage
        }
        
        if (post["isVegan"] as! Bool) != false{
            let veganImage = UIImage(named: "vegan_black")
            cell.veganImage.image = veganImage
        }
        
        if (post["nutFree"] as! Bool) != false{
            let nutFreeImage = UIImage(named: "nut_black")
            cell.peanutFreeImage.image = nutFreeImage
        }
        
        
        let imageFile = post["postImage"] as! PFFileObject
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
            print("Sender is UITableViewCell")
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
    
    func startAnimations() {
        // Start Skeleton
        
        animationView = .init(name: "24703-food-animation")
        // Set the size to the frame
        //animationView!.frame = view.bounds
        animationView!.frame = CGRect(x: view.frame.width / 6 , y: 200, width: 300, height: 300)

        // fit the
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop

        // Animation speed - Larger number = faste
        animationView!.animationSpeed = 2

        //  Play animation
        animationView!.play()
        
    }
    

    @objc func stopAnimations() {
        // ----- Stop Animation
        animationView?.stop()
        
        view.subviews.last?.removeFromSuperview()
        refresh = false
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
