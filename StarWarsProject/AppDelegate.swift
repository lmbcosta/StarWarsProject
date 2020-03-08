//
//  AppDelegate.swift
//  StarWarsProject
//
//  Created by Luis  Costa on 07/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let rootViewController = AppCoordinator.shared.buildRootViewController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

