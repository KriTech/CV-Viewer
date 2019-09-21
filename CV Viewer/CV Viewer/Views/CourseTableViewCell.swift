//
//  CourseTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    var course: Course! {
        didSet {
            self.backgroundColor = .clear
            if let course = self.course {
                
                let titleLabel = UILabel()
                let titleText = "title".localized().capitalized
                titleLabel.text = titleText
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                let titleLabelWidth = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font]).width
                
                let courseTitleLabel = UILabel()
                courseTitleLabel.text = course.name
                courseTitleLabel.numberOfLines = 0
                
                let titleStackView = UIStackView(arrangedSubviews: [titleLabel, courseTitleLabel])
                titleStackView.axis = .horizontal
                titleStackView.alignment = .center
                titleStackView.distribution = .fill
                titleStackView.spacing = 30
                titleStackView.translatesAutoresizingMaskIntoConstraints = false
                
                let issueDateLabel = UILabel()
                let issueDateText = "issueDate".localized().capitalized
                issueDateLabel.text = issueDateText
                issueDateLabel.translatesAutoresizingMaskIntoConstraints = false
                let issueDateLabelWidth = issueDateText.size(withAttributes: [NSAttributedString.Key.font: issueDateLabel.font]).width
                
                let courseIssueDateLabel = UILabel()
                courseIssueDateLabel.text = course.issueDate
                courseIssueDateLabel.numberOfLines = 0
                
                let issueDateStackView = UIStackView(arrangedSubviews: [issueDateLabel, courseIssueDateLabel])
                issueDateStackView.axis = .horizontal
                issueDateStackView.alignment = .center
                issueDateStackView.distribution = .fill
                issueDateStackView.spacing = 30
                issueDateStackView.translatesAutoresizingMaskIntoConstraints = false
                
                let containerStackView = UIStackView(arrangedSubviews: [titleStackView, issueDateStackView])
                containerStackView.translatesAutoresizingMaskIntoConstraints = false
                containerStackView.axis = .vertical
                containerStackView.alignment = .leading
                containerStackView.distribution = .fill
                containerStackView.spacing = 8
                containerStackView.tag = 3
                
                if let url = course.url {
                    
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.openURL))
                    tapRecognizer.numberOfTapsRequired = 1
                    tapRecognizer.numberOfTouchesRequired = 1
                    
                    self.addGestureRecognizer(tapRecognizer)
                    
                    let urlLabel = UILabel()
                    let urlText = "URL"
                    urlLabel.text = urlText
                    urlLabel.translatesAutoresizingMaskIntoConstraints = false
                    let urlLabelWidth = urlText.size(withAttributes: [NSAttributedString.Key.font: urlLabel.font]).width
                    
                    let courseURLLabel = UILabel()
                    courseURLLabel.text = url
                    
                    let urlStackView = UIStackView(arrangedSubviews: [urlLabel, courseURLLabel])
                    urlStackView.axis = .horizontal
                    urlStackView.alignment = .center
                    urlStackView.distribution = .fill
                    urlStackView.spacing = 30
                    urlStackView.translatesAutoresizingMaskIntoConstraints = false
                    
                    containerStackView.addArrangedSubview(urlStackView)
                    
                    urlLabel.widthAnchor.constraint(equalToConstant: max(titleLabelWidth, issueDateLabelWidth, urlLabelWidth) + 5).isActive = true
                    urlStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                }
                
                self.addSubview(containerStackView)
                
                containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
                
                titleStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                issueDateStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
                titleLabel.widthAnchor.constraint(equalToConstant: max(titleLabelWidth, issueDateLabelWidth) + 5).isActive = true
                issueDateLabel.widthAnchor.constraint(equalToConstant: max(titleLabelWidth, issueDateLabelWidth) + 5).isActive = true
            }
        }
    }
    
    @objc private func openURL() {
        if let urlString = self.course.url, let url = URL(string: "https://" + urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func prepareForReuse() {
        if let view = self.viewWithTag(3) {
            view.removeFromSuperview()
        }
    }
}
