//
//  UIViewController+Helper.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupPlusButtonInNavBar(selector: Selector)  {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton()  {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightBlueBackgroundView(height: Float) -> UIView {
        let guide = view.safeAreaLayoutGuide
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        return lightBlueBackgroundView
    }


}
