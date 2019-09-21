//
//  BriefTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    var summary: String! {
        didSet {
            self.backgroundColor = .clear
            if let summary = self.summary {
                let summaryLabel = UILabel()
                summaryLabel.text = summary
                summaryLabel.textAlignment = .justified
                summaryLabel.numberOfLines = 0
                summaryLabel.translatesAutoresizingMaskIntoConstraints = false
                summaryLabel.tag = 3
                
                self.addSubview(summaryLabel)
                
                summaryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                summaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                summaryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
                summaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            }
        }
    }
    
    
    override func prepareForReuse() {
        if let view = self.viewWithTag(3) {
            view.removeFromSuperview()
        }
    }
}
