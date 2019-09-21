//
//  Profile.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 07/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit


class Profile {
    let name: String
    let jobTitle: String
    let profileImage: UIImage
    
    init(name: String, jobTitle: String, imageURLString: String) {
        self.name = name
        self.jobTitle = jobTitle
        guard let imageURL = URL(string: imageURLString), let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) else {
            self.profileImage = UIImage()
            return
        }
        self.profileImage = image
    }
}
