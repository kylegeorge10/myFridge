//
//  ReviewsViewController.swift
//  myFridge
//
//  Created by Kyle George on 4/12/21.
//

import UIKit
import Parse

class ReviewsViewController: UIViewController{ //UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addReviewButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var post: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.dataSource = self
        //tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let reviews = (post["reviews"] as? [PFObject]) ?? []
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewViewCell") as! ReviewViewCell
        
        //let review = reviews[indexPath.row]
        cell.reviewTextField.text = "great recipe" //review["text"] as? String
        
        //let user = review["author"] as! PFUser
        cell.usernameButton.setTitle("username", for: .normal)//user.username, for: .normal)
        
        return cell
    }
 */
    
    @IBAction func onAddReviewButton(_ sender: Any) {
        let post = self.post
        
        func prepare(for segue: UIStoryboardSegue, sender: UIBarButtonItem){
            let addReviewViewController = segue.destination as! addReviewViewController
            addReviewViewController.post = post
        }
        
        performSegue(withIdentifier: "addReviewSegue", sender: sender)
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
