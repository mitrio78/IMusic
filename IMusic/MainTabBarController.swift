//
//  MainTabBarController.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailsController()
    func maximizeTrackDetailsController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    private var minimizedTopAnchorContraints: NSLayoutConstraint!
    private var maximizedTopAnchorContraints: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
//    let library = Library()
    let hostVC = UIHostingController(rootView: Library())
 
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setupTrackDetailView()
        searchVC.tabBarDelegate = self
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(rgb: 0xFD2D55)
        tabBar.backgroundColor = .white
        hostVC.tabBarItem.image = UIImage(named: "library")
        hostVC.tabBarItem.title = "Library"
        viewControllers = [
            hostVC,
            generateViewController(rootViewController: searchVC, image: UIImage(named: "search")!, title: "Search")
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
    
//MARK: Setup Track View
    
    private func setupTrackDetailView() {
        trackDetailView.backgroundColor = .white
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchorContraints = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorContraints = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        bottomAnchorConstraint.isActive = true
        maximizedTopAnchorContraints.isActive = true
        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    func maximizeTrackDetailsController(viewModel: SearchViewModel.Cell?) {
        minimizedTopAnchorContraints.isActive = false
        maximizedTopAnchorContraints.isActive = true
        maximizedTopAnchorContraints.constant = 0
        bottomAnchorConstraint.constant = 0

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.trackDetailView.miniTrackView.alpha = 0
            self.trackDetailView.maximizedStackView.alpha = 1
        }, completion: nil)
        guard let viewModel = viewModel else {
            return
        }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    func minimizeTrackDetailsController() {
        maximizedTopAnchorContraints.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorContraints.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.trackDetailView.miniTrackView.alpha = 1
            self.trackDetailView.maximizedStackView.alpha = 0
        }, completion: nil)
    }
}
