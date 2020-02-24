//
//  ViewController.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/23/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
        func setupNavigationalController() {
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                
                navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.backgroundColor = .lightRed
                self.navigationBar.standardAppearance = navBarAppearance
                self.navigationBar.prefersLargeTitles = true
                self.navigationBar.tintColor = .white
                self.navigationBar.scrollEdgeAppearance = navBarAppearance
            } else {
                // Fallback on earlier versions
                    self.navigationBar.isTranslucent = false
                    self.navigationBar.tintColor = .white
                    self.navigationBar.barTintColor = .lightRed
                    self.navigationBar.prefersLargeTitles = true
                    self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
                    self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
           }
        }
}

