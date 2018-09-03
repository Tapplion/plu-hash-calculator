//
//  InitialTabBarController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 29-05-18.
//  Copyright © 2018 Pascal Kimmel. All rights reserved.
//

import UIKit

class InitialTabBarController: UITabBarController, SettingsConfigurable {
    var settingsController: SettingsController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyStyle()
    }
}

private extension InitialTabBarController {
    func applyStyle() {
        let attributes = [NSAttributedStringKey.foregroundColor: settingsController.scheme.titlesColor]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().barTintColor = settingsController.scheme.navBarColor
        UINavigationBar.appearance().tintColor = settingsController.scheme.titlesColor
        tabBar.tintColor = settingsController.scheme.navBarColor
    }
}
