//
//  PostingCompleteViewController.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 6/2/21.
//

import UIKit
import Lottie

class PostingCompleteViewController: UIViewController {

    @IBOutlet weak var animationViewTop: AnimationView!
    @IBOutlet weak var animationViewBottom: AnimationView!
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animationViewTop.contentMode = .scaleAspectFit
        animationViewTop.loopMode = .loop
        animationViewTop.animationSpeed = 1
        animationViewTop.play()
        
        animationViewBottom.contentMode = .scaleAspectFill
        animationViewBottom.loopMode = .playOnce
        animationViewBottom.animationSpeed = 1
        animationViewBottom.play()
        
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timeaction), userInfo: nil, repeats: true)
    }
    
    @objc func timeaction(){
        //self.performSegue(withIdentifier: "signupSegue", sender: nil)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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
