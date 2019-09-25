//
//  AppDelegate.swift
//  ReachabilityExample
//
//  Created by Станислав Шияновский on 9/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

