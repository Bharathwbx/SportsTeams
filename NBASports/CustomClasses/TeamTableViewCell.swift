//
//  TeamTableViewCell.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    var team: Team? {
        didSet {
            nameLabel.text = team?.name ?? ""
            if let imageData = team?.imageData {
                teamImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    let teamImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Team Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.tearColor
        
        addSubview(teamImageView)
        teamImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        teamImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        teamImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        teamImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: teamImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
