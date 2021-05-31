//
//  SignInTransitionViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 5/29/21.
//

import UIKit
import Lottie

class SignInTransitionViewController: UIViewController {
    
    //var animationView: AnimationView?
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        animationView = .init(name: "4986-cookiesmilk")
//        animationView!.frame = view.bounds
//        animationView!.contentMode = .scaleAspectFit
//        animationView!.loopMode = .loop
//        animationView!.animationSpeed = 1
//        view.addSubview(animationView!)
//        animationView!.play()
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        
        startButton.layer.cornerRadius = startButton.frame.size.width / 7.5
        startButton.layer.borderColor = UIColor.systemGreen.cgColor
        startButton.layer.borderWidth = 3.5
        
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
