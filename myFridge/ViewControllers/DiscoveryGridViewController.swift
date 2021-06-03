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
    
    @IBOutlet weak var isVeganSwitch: UISwitch!
    @IBOutlet weak var isVeganImage: UIImageView!
    
    @IBOutlet weak var isGlutenSwitch: UISwitch!
    @IBOutlet weak var isGlutenImage: UIImageView!
    
    @IBOutlet weak var isNutSwitch: UISwitch!
    @IBOutlet weak var isNutImage: UIImageView!
    
    @IBOutlet weak var onNextButton: UIButton!
    @IBOutlet weak var onClearButton: UIButton!
    @IBOutlet weak var onSearchButton: UIButton!
    
    @IBOutlet weak var searchReturnLabel: UILabel!
    
    // declare a list to store the user's fridge inventory
    var itemList: Array<String> = Array()
    var ingredientsList: Array<String> = Array()
    var posts = [PFObject]()
    var filteredPosts = [PFObject]()
    var isGood = false
    var position = 0
    var postPosition = 0
    var currPosts = [PFObject]()
    
    var isVegan = false
    var isGluten = false
    var isNut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //button desgin
        onNextButton.layer.cornerRadius = onNextButton.frame.size.width/7.5
        onNextButton.layer.borderWidth = 0.5
        onNextButton.layer.borderColor = UIColor.systemOrange.cgColor
        
        onClearButton.layer.cornerRadius = onClearButton.frame.size.width/7.5
        onClearButton.layer.borderWidth = 0.5
        onClearButton.layer.borderColor = UIColor.systemOrange.cgColor
        
        onSearchButton.layer.cornerRadius = onSearchButton.frame.size.width/7.5
        onSearchButton.layer.borderWidth = 0.5
        onSearchButton.layer.borderColor = UIColor.systemOrange.cgColor
        
        postPosition = 0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        

        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 1) / 2
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)

        // Do any additional setup after loading the view.
        
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                print("count", posts!.count)
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
        
        //checking the filters
        if isVeganSwitch.isOn{
            isVegan = true
            let vaganImage = UIImage(named: "vegan_black")
            isVeganImage.image = vaganImage
        }
        
        if isGlutenSwitch.isOn{
            isGluten = true
            let glutenImage = UIImage(named: "gluten_black")
            isGlutenImage.image = glutenImage
        }
        
        if isNutSwitch.isOn{
            isNut = true
            let nutImage = UIImage(named: "nut_black")
            isNutImage.image = nutImage
        }
        
    }
    
    @IBAction func onClearButton(_ sender: UIButton) {
        if itemList != []{
            itemList.popLast()
            showItemsLabel.text = itemList.joined(separator: ", ")
        } else {
            showItemsLabel.text = "List of Items I have"
        }
        if itemList.count == 0{
            showItemsLabel.text = "List of Items I have"
            addItemsTextField.placeholder = "Add the items you have"
            //resetting the filters
            if isVeganSwitch.isOn{
                isVegan = false
                let vaganImage = UIImage(named: "vegan_white")
                isVeganImage.image = vaganImage
                isVeganSwitch.setOn(false, animated: true)
            }
            
            if isGlutenSwitch.isOn{
                isGluten = false
                let glutenImage = UIImage(named: "gluten_white")
                isGlutenImage.image = glutenImage
                isGlutenSwitch.setOn(false, animated: true)
            }
            
            if isNutSwitch.isOn{
                isNut = false
                let nutImage = UIImage(named: "nut_white")
                isNutImage.image = nutImage
                isNutSwitch.setOn(false, animated: true)
            }
            
            
            filteredPosts.removeAll()
            currPosts.removeAll()
        
            collectionView.reloadData()
            onSearchButton.sendActions(for: .touchUpInside)
        
            
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
        
        position = 0
        postPosition = 0
        filteredPosts.removeAll()
        currPosts.removeAll()
        
        
        var position = 0
        while position <= (self.posts.count-1){

            //print(self.posts as Any)
            //move ingredients of the current post to a list and format it
            //let ingredients = self.posts[position]["ingredients"] as? String
            let ingredients = self.posts[position]["ingredients"] as! Array<Any>
            //print(ingredients as Any)
            //let tempIngredientsList = ingredients.components(separatedBy: ",")
//            for item in tempIngredientsList{
//                ingredientsList.append((item.trimmingCharacters(in: .whitespaces)).lowercased())
//            }
            for item in ingredients{
                ingredientsList.append(((item as AnyObject).trimmingCharacters(in: .whitespaces)).lowercased())
            }
            print(ingredientsList)

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
        
        print("filteredPosts",filteredPosts)
        //add the switch filtered posts
        
        //checking for vegan foods
        print("vegan toggle",isVegan)
        if isVegan == true{
            //print("yes isVegan toggle on")
            for allPosts in self.posts{
                if allPosts["isVegan"] as! Int != 0{
                    if filteredPosts.contains(allPosts){
                        print("found the same recipe, skip")
                    }else{
                        filteredPosts.append(allPosts)
                    }
                    
                }else{
                    print("Not Vegan")
                }
            }
        }
        
        //checking for gluten free foods
        print("gulten toggle",isGluten)
        if isGluten == true{
            //print("yes isGluten toggle on")
            for allPosts in self.posts{
                if allPosts["glutenFree"] as! Int != 0{
                    if filteredPosts.contains(allPosts){
                        print("found the same recipe, skip")
                    }else{
                        filteredPosts.append(allPosts)
                    }
                    
                }else{
                    print("Not Glutan Free")
                }
            }
        }
        
        //checking for nut free foods
        print("nut toggle", isNut)
        if isNut == true{
            //print("yes isNut toggle on")
            for allPosts in self.posts{
                if allPosts["nutFree"] as! Int != 0{
                    if filteredPosts.contains(allPosts){
                        print("found the same recipe, skip")
                    }else{
                        filteredPosts.append(allPosts)
                    }
                    
                }else{
                    print("Not Nut Free")
                }
            }
        }

        
        //print(filteredPosts.count)
        if filteredPosts.count == 0{
            searchReturnLabel.textColor = UIColor.systemPink
            searchReturnLabel.layer.borderColor = UIColor.secondarySystemBackground.cgColor
            searchReturnLabel.layer.borderWidth = 0
            searchReturnLabel.text = "Search Result"
        }else{
            searchReturnLabel.textColor = UIColor.systemGreen
            searchReturnLabel.text = "Found \(filteredPosts.count) Recipes"
            searchReturnLabel.layer.cornerRadius = searchReturnLabel.frame.size.width/10.5
            searchReturnLabel.layer.borderWidth = 3
            searchReturnLabel.layer.borderColor = UIColor.systemGreen.cgColor
        }
        
        //print(filteredPosts[0]["recipeName"] as! String)
        print("filteredPosts",filteredPosts)
        
        //reload the collection view to show only the filtered posts
        self.collectionView.reloadData()
        print("data reloaded")

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when not in use
        
        addItemsTextField.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if filteredPosts.count != 0{
            return filteredPosts.count
        }else{
            return posts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("IN COLLECTION VIEW")
        //var position: Int
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeFoundCell", for: indexPath) as! RecipeFoundCell
        
        print(filteredPosts.count)
        
        if filteredPosts.count != 0{
            print("IN IF")
            print("position: ", position)
            //print(filteredPosts.count)
            
            if position <= filteredPosts.count-1{
                print("IN IFFFF")
                let post = filteredPosts[position]
                
                print(filteredPosts[position])
                
                cell.recipeNameLabel.text = post["recipeName"] as? String
                
                let imageFile = post["postImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                cell.recipeImageView.af_setImage(withURL: url)
                
                currPosts.append(filteredPosts[position])
                cell.recipeImageView.layer.cornerRadius = cell.recipeImageView.frame.size.width / 9.5
                cell.recipeImageView.layer.borderWidth = 2.5
                cell.recipeImageView.layer.borderColor = UIColor.systemGreen.cgColor
                
            }
            
        }
        else{
            
            print("IN ELSE")
            if postPosition <= posts.count-1{
                let post = posts[postPosition]
                
                cell.recipeNameLabel.text = post["recipeName"] as? String
                
                let imageFile = post["postImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                cell.recipeImageView.af_setImage(withURL: url)
                
                currPosts.append(posts[postPosition])
            }
        }
        position += 1
        postPosition += 1
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = currPosts[indexPath.item]
        print(post)

        // Pass the selected post to the details view controller
        let detailsViewController = segue.destination as! DetailViewController
        detailsViewController.post = post
        print("END OF SEGUE")

        //collectionView.deselectRow(at: indexPath,animated: true)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        let post = currPosts[indexPath.item]
//
//        func prepare(segue: UIStoryboardSegue, sender: UICollectionViewCell){
//            let detailsViewController = segue.destination as! DetailViewController
//            detailsViewController.post = post
//        }
//        performSegue(withIdentifier: "collectionToDetailSegue", sender: cell)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//            // ATTEMPT 1:
//
////        let cell = storyboard?.instantiateViewController(identifier: "detailViewController") as? DetailViewController
////        cell!.post = posts[indexPath.item]
////        print(posts[indexPath.item])
////        self.navigationController?.pushViewController(cell!, animated: true)
//
//        // ATTEMPT 2:
//
////        func prepare(for segue: UIStoryboardSegue, sender: Any?){
////            if segue.identifier == "collectionToDetailSegue"{
////                let cell = sender as! UICollectionViewCell
////                let indexPath = collectionView.indexPath(for: cell)!
////                let post = posts[indexPath.item]
////
////                let detailsViewController = segue.destination as! DetailViewController
////                detailsViewController.post = post
////            }
////
////        }
//    }
    
        //ATTEMPT 3 :
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "collectionToDetailSegue"{
//            if let dest = segue.destination as? DetailViewController, let index = collectionView.indexPathsForSelectedItems?.first{ // <------------- this "first" looks very suspicious for the problem we have now
//                dest.post = posts[index.item]
//            }
//        }
//    }
    
    
        // ATTEMPT 4: (workes exactly like the ATTEMPT 3 and has the same issue)
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        // Find the selected post
//        if sender is UICollectionViewCell{
//            print("Sender is UICollectionViewCell")
//            let cell = sender as! UICollectionViewCell
//            let indexPath = collectionView.indexPath(for: cell)!
//            let post = posts[indexPath.item]
//
//            // Pass the selected post to the details view controller
//            let detailsViewController = segue.destination as! DetailViewController
//            detailsViewController.post = post
//
////            collectionView.deselectRow(at: indexPath,animated: true)
//        }
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
