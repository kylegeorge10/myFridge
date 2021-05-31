//
//  AppDelegate.swift
//  myFridge
//
//  Created by Kyle George on 3/29/21.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let parseConfig = ParseClientConfiguration {
                    
                    //Kyle's Parse
                    //$0.applicationId = "IJzP9N0e9HpsDgQhOLSirYaUaquDKm8wjGIS2zpH"
                    //$0.clientKey = "7IQxdbRtZJBnw5OiBu24A9aX1iSWz9bOVLOklW7J"
                    
                    //Senuda's Parse
//                    $0.applicationId = "RTm5AC0nYB7cVLGt5P9E8DS7VToS41M2amM2oQfh"
//                    $0.clientKey = "Pr4BESsGeUtweM7x2wuqLTTIeACn8b2apAQ9Fsm9"
//                    $0.server = "https://parseapi.back4app.com"
            
            //Second Parse version
            $0.applicationId = "UaaRPhLAGfj4G9ppcYQL6p8eTv9xubnTJH9HFyTL"
            $0.clientKey = "lCcxW8Y00Bx7sVVV7d6tQT33abVGO41wGQPh4Dbo"
            $0.server = "https://parseapi.back4app.com/"
            }
            Parse.initialize(with: parseConfig)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

