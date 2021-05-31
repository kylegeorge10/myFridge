//
//  SignUpSuccessViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 5/31/21.
//

import UIKit
import Lottie

class SignUpSuccessViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1
        animationView.play()
        
        animationView.layer.cornerRadius = animationView.frame.size.width / 7.5
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timeaction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeaction(){
        self.performSegue(withIdentifier: "signupSegue", sender: nil)
        timer.invalidate()//after that timer invalid

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
