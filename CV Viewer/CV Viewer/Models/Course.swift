//
//  Course.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 07/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import Foundation


class Course {
    
    let name: String
    let issueDate: String
    let url: String?
    
    init(name: String, issueDate: String, url: String? = nil) {
        self.name = name
        self.issueDate = issueDate
        self.url = url
    }
}
