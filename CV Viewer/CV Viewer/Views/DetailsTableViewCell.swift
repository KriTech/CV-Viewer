//
//  DetailsTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    var detail: String! {
        didSet {
            self.backgroundColor = .clear
            if let detail = self.detail {
                let detailLabel = UILabel()
                detailLabel.text = detail.lowercased().localized()
                detailLabel.textAlignment = .center
                detailLabel.translatesAutoresizingMaskIntoConstraints = false
                detailLabel.tag = 3
                
                self.addSubview(detailLabel)
                
                detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                detailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                detailLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
                detailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            }
        }
    }

    override func prepareForReuse() {
        if let view = self.viewWithTag(3) {
            view.removeFromSuperview()
        }
    }
}
