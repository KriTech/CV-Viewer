//
//  Details.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 07/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import Foundation


class Details {
    
    let details: [String]
    init(phoneNumber: String, email: String, nationality: String) {
        self.details = [phoneNumber, email, nationality]
    }
}
