//
//  UIStoryboard.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

fileprivate let globalState = State()

extension UIStoryboard {
    fileprivate var state: State {
        return globalState
    }
    
    func configure(viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController {
            navigationController.viewControllers.first.map(configure(viewController:))
        }
        
        if let tabBarController = viewController as? UITabBarController {
            tabBarController.viewControllers?.first.map(configure(viewController:))
            tabBarController.delegate = self
        }
        
        if let statefulController = viewController as? Stateful {
            statefulController.stateController = state.stateController
        }
        
        if let congigurableController = viewController as? SettingsConfigurable {
            congigurableController.settingsController = state.settingsController
        }
    }
}

extension UIStoryboard: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        configure(viewController: viewController)
        return true
    }
}
