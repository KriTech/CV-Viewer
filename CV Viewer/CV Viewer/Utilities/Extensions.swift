//
//  Extensions.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 15/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
    }
    
}
