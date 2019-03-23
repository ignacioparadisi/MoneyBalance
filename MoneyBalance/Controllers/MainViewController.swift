//
//  ViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/4/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainViewController: UITabBarController {
    
    let homeViewController: HomeViewController = HomeViewController()
    let movementsViewController: MovementsViewController = MovementsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItemsImages()
        
        let viewControllersList: [UIViewController] =
            [homeViewController,
             movementsViewController]
        
        let navigationControllers: [UINavigationController] = viewControllersList.map {
            UINavigationController(rootViewController: $0)
        }
        viewControllers = navigationControllers
        viewControllers?.forEach {
            $0.title = ""
            $0.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    /// Sets view controller's tabBarItem images
    private func setTabBarItemsImages() {
        homeViewController.tabBarItem.image = UIImage(named: "wallet")
        movementsViewController.tabBarItem.image = UIImage(named: "movements")
    }

}

