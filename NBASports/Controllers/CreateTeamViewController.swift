//
//  CreateTeamViewController.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit
import CoreData

protocol CreateTeamViewControllerDelegate {
    func didAddTeam(_ team: Team)
    func didEditTeam(_ team: Team)

}

class CreateTeamViewController: UIViewController {
    
    var delegate: CreateTeamViewControllerDelegate?
    
    var team: Team? {
        didSet {
            nameTextField.text = team?.name
            
            if let imageData = team?.imageData {
                teamImageView.image = UIImage(data: imageData)
                setUpCircularImageStyle()
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Team Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var teamImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupNavigationalController()
        setupCancelButton()
        view.backgroundColor = .darkBlue
        _ = setupLightBlueBackgroundView(height: 50)
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = team == nil ? "Create Team" : "Edit Team"
    }
    
    @objc private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func setUpCircularImageStyle() {
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamImageView.clipsToBounds = true
        teamImageView.layer.borderColor = UIColor.lightBlue.cgColor
        teamImageView.layer.borderWidth = 2
    }
        
    @objc func handleSave() {
        if team == nil {
            createTeam()
        } else {
            saveTeamChanges()
        }
    }
    
    private func saveTeamChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        team?.name = nameTextField.text
        if let teamImage = teamImageView.image {
            let imageData = teamImage.jpegData(compressionQuality: 0.8)
            team?.imageData = imageData
        }
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didEditTeam(self.team!)
            }
        } catch let saveErr {
            print("Failed to save Company changes \(saveErr)")
        }
    }
    
    private func createTeam() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: context)
        team.setValue(nameTextField.text, forKey: "name")
        if let teamImage = teamImageView.image {
            let imageData = teamImage.jpegData(compressionQuality: 0.8)
            team.setValue(imageData, forKey: "imageData")
        }
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddTeam(team as! Team)
            }
        } catch let saveErr {
            print("Failed to save company...", saveErr)
        }
    }
    
    
    
    private func setupUI() {
        let guide = view.safeAreaLayoutGuide
        
        _ = setupLightBlueBackgroundView(height: 350)
        
        view.addSubview(teamImageView)
        teamImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8).isActive = true
        teamImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        teamImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        teamImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: teamImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: teamImageView.bottomAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
