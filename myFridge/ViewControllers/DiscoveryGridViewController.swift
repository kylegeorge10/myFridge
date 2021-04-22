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
    var ingredientsList: Array<String> = Array()
    var posts = [PFObject]()
    var filteredPosts = [PFObject]()
    var isGood = false
    
    let query = PFQuery(className:"Posts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 1) / 2
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)

        // Do any additional setup after loading the view.
        
        query.findObjectsInBackground{(posts, error) in
            if posts != nil{
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func onNextItemButton(_ sender: Any) {
        itemList.append(addItemsTextField.text!)
        if itemList.count != 0{
            //print(itemList)
            showItemsLabel.text = itemList.joined(separator: ", ")
        } else {
            print("None")
        }
        addItemsTextField.text?.removeAll()
        if itemList.count != 0{
            addItemsTextField.placeholder = "Add another item"
        }
    }
    
    @IBAction func onClearButton(_ sender: UIButton) {
        if itemList != []{
            itemList.popLast()
            showItemsLabel.text = itemList.joined(separator: ", ")
        } else {
            showItemsLabel.text = "List of Items I have"
        }
        if itemList == []{
            showItemsLabel.text = "List of Items I have"
            addItemsTextField.placeholder = "Add the items you have"
            
            //also reload the collection view back to the random posts if the person removes their
            //inputted ingredients
        }
    }
    
    @IBAction func onSearchButton(_ sender: UIButton) {
        //print(itemList)
        //print(posts.count)
        
        //WHAT WE NEED TO DO:
        
        //1:
        //Run a loop that collects the ingredient of each post and check to see if the ingredients of that post
        //match the ingredients on our fridge
        
        //2:
        //Once we find the posts (if any) that match our ingredients we then want to add that post to a list of
        //posts that we can use to reload the data of the collection table to show only those posts
        
        filteredPosts.removeAll()
        var position = 0
        while position <= (self.posts.count-1){
            
            //move ingredients of the current post to a list and format it
            let ingredients = self.posts[position]["ingredients"] as! String
            let tempIngredientsList = ingredients.components(separatedBy: ",")
            for item in tempIngredientsList{
                ingredientsList.append((item.trimmingCharacters(in: .whitespaces)).lowercased())
            }
            //print(ingredientsList)
            
            //check if ingredients are in posts ingredient list
            for item in itemList{
                if ingredientsList.contains(item.lowercased()){
                    isGood = true
                }else{
                    isGood = false
                }
            }
            
            //if ingredients are in posts ingredients list then add that recipe to the recipe collection
            if isGood{
                //add post to a list of posts that match our ingredients
                //filteredPosts.append(post)
                print("good recipe")
                filteredPosts.append(self.posts[position])
                isGood = false
            }
            ingredientsList.removeAll()
            position += 1
        }
        print(filteredPosts.count)
        //print(filteredPosts[0]["recipeName"] as! String)
        
        
        //reload the collection view to show only the filtered posts
        self.collectionView.reloadData()
        print("data reloaded")
        
        
        
        /*
        query.countObjectsInBackground { (count: Int32, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                print("\(count) objects found!")
                
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeFoundCell", for: indexPath) as! RecipeFoundCell
            
            let post = posts[indexPath.item]
            
            cell.recipeNameLabel.text = post["recipeName"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.recipeImageView.af_setImage(withURL: url)
            return cell
        }
        
        self.collectionView.reloadData()
        print("data reloaded")
        */
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when not in use
        
        addItemsTextField.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("IN COLLECTION VIEW")
        var position: Int
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeFoundCell", for: indexPath) as! RecipeFoundCell
        
        if filteredPosts.count != 0{
            print("IN IF")
            let post = filteredPosts[indexPath.item]
            
            cell.recipeNameLabel.text = post["recipeName"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.recipeImageView.af_setImage(withURL: url)
        }else{
            
            let post = posts[indexPath.item]
            
            cell.recipeNameLabel.text = post["recipeName"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.recipeImageView.af_setImage(withURL: url)
        }
        
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
