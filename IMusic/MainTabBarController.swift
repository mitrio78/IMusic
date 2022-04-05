//
//  MainTabBarController.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(rgb: 0xFD2D55)
        viewControllers = [
            generateViewController(rootViewController: searchVC, image: UIImage(named: "search")!, title: "Search"),
            generateViewController(rootViewController: ViewController(), image: UIImage(named: "library")!, title: "Library")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
