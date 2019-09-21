//
//  JobDescriptionTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class JobDescriptionTableViewCell: UITableViewCell {

    var job: Job! {
        didSet {
            self.backgroundColor = .clear
            if let job = self.job {
                
                let titleLabel = UILabel()
                let titleText = "position".localized().capitalized
                titleLabel.text = titleText
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                let titleLabelWidth = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font]).width
                
                let jobTitleLabel = UILabel()
                jobTitleLabel.text = job.title
                jobTitleLabel.numberOfLines = 0
                
                let titleStackView = UIStackView(arrangedSubviews: [titleLabel, jobTitleLabel])
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
                
                let jobPeriodLabel = UILabel()
                jobPeriodLabel.text = job.period
                jobPeriodLabel.numberOfLines = 0
                
                let periodStackView = UIStackView(arrangedSubviews: [periodLabel, jobPeriodLabel])
                periodStackView.axis = .horizontal
                periodStackView.alignment = .center
                periodStackView.distribution = .fill
                periodStackView.spacing = 30
                periodStackView.translatesAutoresizingMaskIntoConstraints = false
                
                let activitiesLabel = UILabel()
                activitiesLabel.text = "activities".localized().capitalized + ":"
                
                let containerStackView = UIStackView(arrangedSubviews: [titleStackView, periodStackView, activitiesLabel])
                containerStackView.axis = .vertical
                containerStackView.alignment = .leading
                containerStackView.distribution = .fill
                containerStackView.spacing = 8
                containerStackView.translatesAutoresizingMaskIntoConstraints = false
                containerStackView.tag = 3
                
                for activity in job.activities {
                    let activityLabel = UILabel()
                    activityLabel.text = "• " + activity
                    activityLabel.numberOfLines = 0
                    containerStackView.addArrangedSubview(activityLabel)
                }
                
                self.addSubview(containerStackView)
                
                containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
                
                titleStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                periodStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                periodLabel.widthAnchor.constraint(equalToConstant: max(periodLabelWidth, titleLabelWidth) + 5).isActive = true
                titleLabel.widthAnchor.constraint(equalToConstant: max(periodLabelWidth, titleLabelWidth) + 5).isActive = true
            }
        }
    }
    
    override func prepareForReuse() {
        if let view = self.viewWithTag(3) {
            view.removeFromSuperview()
        }
    }
}
