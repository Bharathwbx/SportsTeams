//
//  CreatePlayerViewController.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

protocol CreatePlayerViewControllerDelegate {
    func didAddPlayer(_ player: Player)
}

class CreatePlayerViewController: UIViewController {
    
    var team: Team?
    var delegate: CreatePlayerViewControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Player Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupNavigationalController()
        navigationItem.title = "Create Player"
        setupCancelButton()
        view.backgroundColor = .darkBlue
        _ = setupLightBlueBackgroundView(height: 50)
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let playerName = nameTextField.text else { return }
        guard let team = team else { return }
        let tuple = CoreDataManager.shared.createPlayer(playerName: playerName, team: team)
        if let error = tuple.1 {
            print("Error occured while saving...", error)
        } else {
            dismiss(animated: true) {
                self.delegate?.didAddPlayer(tuple.0!)
            }
        }
    }
    
    func setupUI() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(nameLabel)
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
    }
}
