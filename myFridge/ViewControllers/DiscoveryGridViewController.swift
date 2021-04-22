//
//  DiscoveryGridViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 4/19/21.
//

import UIKit
import Parse
import AlamofireImage

class DiscoveryGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var addItemsTextField: UITextField!
    @IBOutlet weak var showItemsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // declare a list to store the user's fridge inventory
    var itemList: Array<String> = Array()
    var posts = [PFObject]()
    
    let query = PFQuery(className:"Posts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNextItemButton(_ sender: Any) {
        itemList.append(addItemsTextField.text!)
        if itemList != nil{
            print(itemList)
            showItemsLabel.text = itemList.joined(separator: ", ")
        } else {
            print("None")
        }
    }
    
    @IBAction func onClearButton(_ sender: UIButton) {
        if itemList != []{
            itemList.popLast()
            showItemsLabel.text = itemList.joined(separator: ", ")
        } else {
            showItemsLabel.text = "List of Items I have"
        }
    }
    
    @IBAction func onSearchButton(_ sender: UIButton) {
        print(itemList)
        query.countObjectsInBackground { (count: Int32, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                print("\(count) objects found!")
                
            }
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when not in use
        
        addItemsTextField.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeFoundCell", for: indexPath) as! RecipeFoundCell
        
        let post = posts[indexPath.item]
        
        cell.recipeNameLabel.text = post["recipeName"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.recipeImageView.af_setImage(withURL: url)
        return cell
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
