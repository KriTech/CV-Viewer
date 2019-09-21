//
//  SchoolDescriptionTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class SchoolDescriptionTableViewCell: UITableViewCell {

    var schoolGrade: SchoolGrade! {
        didSet {
            self.backgroundColor = .clear
            if let schoolGrade = self.schoolGrade {
                let titleLabel = UILabel()
                let titleText = "title".localized().capitalized
                titleLabel.text = titleText
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                let titleLabelWidth = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font]).width
                
                let schoolTitleLabel = UILabel()
                schoolTitleLabel.text = schoolGrade.title
                schoolTitleLabel.numberOfLines = 0
                
                let titleStackView = UIStackView(arrangedSubviews: [titleLabel, schoolTitleLabel])
                titleStackView.axis = .horizontal
                titleStackView.alignment = .center
                titleStackView.distribution = .fill
                titleStackView.spacing = 30
                titleStackView.translatesAutoresizingMaskIntoConstraints = false
                
                let periodLabel = UILabel()
                let periodText = "period".localized().capitalized
                periodLabel.text = periodText
                periodLabel.translatesAutoresizingMaskIntoConstraints = false
                let periodLabelWidth = periodText.size(withAttributes: [NSAttributedString.Key.font: periodLabel.font]).width
                
                let schoolPeriodLabel = UILabel()
                schoolPeriodLabel.text = schoolGrade.period
                schoolPeriodLabel.numberOfLines = 0
                
                let periodStackView = UIStackView(arrangedSubviews: [periodLabel, schoolPeriodLabel])
                periodStackView.axis = .horizontal
                periodStackView.alignment = .center
                periodStackView.distribution = .fill
                periodStackView.spacing = 30
                periodStackView.translatesAutoresizingMaskIntoConstraints = false
                
                let descriptionLabel = UILabel()
                let descriptionText = "description".localized().capitalized
                descriptionLabel.text = descriptionText
                descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                let descriptionLabelWidth = descriptionText.size(withAttributes: [NSAttributedString.Key.font: descriptionLabel.font]).width
                
                let schoolDescriptionLabel = UILabel()
                schoolDescriptionLabel.text = schoolGrade.description
                schoolDescriptionLabel.numberOfLines = 0
                
                let descriptionStackView = UIStackView(arrangedSubviews: [descriptionLabel, schoolDescriptionLabel])
                descriptionStackView.axis = .horizontal
                descriptionStackView.alignment = .center
                descriptionStackView.distribution = .fill
                descriptionStackView.spacing = 30
                descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
                
                let containerStackView = UIStackView(arrangedSubviews: [titleStackView, periodStackView, descriptionStackView])
                containerStackView.axis = .vertical
                containerStackView.alignment = .leading
                containerStackView.distribution = .fill
                containerStackView.spacing = 8
                containerStackView.translatesAutoresizingMaskIntoConstraints = false
                containerStackView.tag = 3
                
                self.addSubview(containerStackView)
                
                containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
                
                titleLabel.widthAnchor.constraint(equalToConstant: max(titleLabelWidth, periodLabelWidth, descriptionLabelWidth) + 5).isActive = true
                periodLabel.widthAnchor.constraint(equalToConstant: max(titleLabelWidth, periodLabelWidth, descriptionLabelWidth) + 5).isActive = true
                descriptionLabel.widthAnchor.constraint(equalToConstant: max(titleLabelWidth, periodLabelWidth, descriptionLabelWidth) + 5).isActive = true
                
                titleStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                periodStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                descriptionStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
            }
        }
    }
    
    override func prepareForReuse() {
        if let view = self.viewWithTag(3) {
            view.removeFromSuperview()
        }
    }
}
