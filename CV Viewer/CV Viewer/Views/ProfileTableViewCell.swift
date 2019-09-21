 //
//  PictureTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var profile: Profile! {
        didSet {
            
            self.backgroundColor = .clear
            if let profile = self.profile {
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.alignment = .center
                stackView.distribution = .fill
                stackView.axis = .vertical
                stackView.spacing = 7
                stackView.tag = 3
                
                let nameLabel = UILabel()
                nameLabel.text = profile.name
                
                let jobLabel = UILabel()
                jobLabel.text = profile.jobTitle
                
                let profileImage = UIImageView(image: profile.profileImage)
                profileImage.contentMode = .scaleAspectFill
                profileImage.translatesAutoresizingMaskIntoConstraints = false
                profileImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
                profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
                profileImage.clipsToBounds = true
                profileImage.layer.cornerRadius = 10
                
                stackView.addArrangedSubview(profileImage)
                stackView.addArrangedSubview(nameLabel)
                stackView.addArrangedSubview(jobLabel)
                
                self.addSubview(stackView)
                
                stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            }
        }
    }
    
    
    override func prepareForReuse() {
        if let view = self.viewWithTag(3) {
            view.removeFromSuperview()
        }
    }
    
}
