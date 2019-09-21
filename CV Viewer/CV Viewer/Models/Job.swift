//
//  Job.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 07/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import Foundation

class Job {
    
    
    let title: String
    let period: String
    let activities: [String]
    
    init(title: String, period: String, activities: [String] = []) {
        self.title = title
        self.period = period
        self.activities = activities
    }
    
}

