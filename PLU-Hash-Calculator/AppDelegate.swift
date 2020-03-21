//
//  AppDelegate.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let rootViewController = window?.rootViewController as? InitialTabBarController,
            let storyboard = rootViewController.storyboard {
            storyboard.configure(viewController: rootViewController)
        }
        return true
    }
}
