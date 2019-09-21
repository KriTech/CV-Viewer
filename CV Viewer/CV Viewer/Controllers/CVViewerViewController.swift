//
//  ViewController.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class CVViewerViewController: UIViewController {
    
    var curriculum: CV!
    var tableView: UITableView!
    let gradientLayer = CAGradientLayer()
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpStyle()
        self.registerCells()
        self.presentLoadingIndicator()
        CVStorage.shared.fetchAndParseCV(from: "https://raw.githubusercontent.com/KriTech/assets/master/CV.json" ,completion: { () in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                self.curriculum = CVStorage.shared.gertCVAt(index: 0)
                self.tableView.reloadData()
            }
        }) { (errorType) in
            DispatchQueue.main.async {
                self.removeLoadingIndicator()
                let errorAlert = UIAlertController(title: "error".localized().capitalized, message: errorType.rawValue.localized(), preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "ok".localized().capitalized, style: .default, handler: { (action) in
                    exit(0)
                }))
                
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }
    
    private func setUpStyle() {
        
        self.gradientLayer.colors = [#colorLiteral(red: 0.1700862944, green: 0.4943776131, blue: 0.6336901784, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 0.8792688251, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = .clear
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = .black
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(self.tableView)
        
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    private func registerCells() {
        self.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: CVStorage.profileCellIdentifier)
        self.tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: CVStorage.summaryCellIdentifier)
        self.tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: CVStorage.detailsCellIdentifier)
        self.tableView.register(JobDescriptionTableViewCell.self, forCellReuseIdentifier: CVStorage.jobCellIdentifier)
        self.tableView.register(SchoolDescriptionTableViewCell.self, forCellReuseIdentifier: CVStorage.schoolCellIdentifier)
        self.tableView.register(CourseTableViewCell.self, forCellReuseIdentifier: CVStorage.courseCellIdentifier)
        self.tableView.register(SkillTableViewCell.self, forCellReuseIdentifier: CVStorage.skillCellIdentifier)
        self.tableView.register(SkillTableViewCell.self, forCellReuseIdentifier: CVStorage.languageCellIdentifier)
    }
    
    private func presentLoadingIndicator() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.startAnimating()
        self.activityIndicator.color = .black
        
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    private func removeLoadingIndicator() {
        self.activityIndicator.removeFromSuperview()
        self.activityIndicator.stopAnimating()
    }
    
}

// MARK:- Table View Data Source
extension CVViewerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let cv = self.curriculum {
            return cv.numberOfSections
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cv = self.curriculum else {
            return 0
        }
        
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 1
        default:
            if let numberOfItems = cv.numberOfItemsInSection(numberOfSection: section) {
                return numberOfItems
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return self.getProfileCell(tableView)
        case 1:
            return self.getDetailsCell(tableView, detailCellForRowAt: indexPath)
        case 2:
            return self.getSummaryCell(tableView)
        default:
            if let sectionId = self.curriculum.identifierForCellIn(section: indexPath.section) {
                switch sectionId {
                case CVStorage.jobCellIdentifier:
                    return self.getJobCell(tableView, forRow: indexPath.row)
                case CVStorage.courseCellIdentifier:
                    return self.getCourseCell(tableView, forRow: indexPath.row)
                case CVStorage.schoolCellIdentifier:
                    return self.getSchoolGradeCell(tableView, forRow: indexPath.row)
                case CVStorage.skillCellIdentifier:
                    return self.getSkillCell(tableView, forRow: indexPath.row)
                case CVStorage.languageCellIdentifier:
                    return self.getLanguageCell(tableView, forRow: indexPath.row)
                default:
                    break
                }
            }
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "details".localized().capitalized
        case 2:
            return "summary".localized().capitalized
        default:
            return self.curriculum.sectionTitle(forSection: section)
        }
    }
    
    private func getProfileCell(_ tableView: UITableView) -> UITableViewCell {
        if let profileCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.profileCellIdentifier) as? ProfileTableViewCell {
            
            profileCell.profile = self.curriculum.profile
            
            return profileCell
        }
        
        let profileCell = ProfileTableViewCell()
        profileCell.profile = self.curriculum.profile
        
        return profileCell
    }
    
    private func getDetailsCell(_ tableView: UITableView, detailCellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let detailCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.detailsCellIdentifier) as? DetailsTableViewCell {
            
            detailCell.detail = self.curriculum.details.details[indexPath.row]
            
            return detailCell
        }
        
        let detailCell = DetailsTableViewCell()
        detailCell.detail = self.curriculum.details.details[indexPath.row]
        
        return detailCell
    }
    
    private func getSummaryCell(_ tableView: UITableView) -> UITableViewCell {
        if let summaryCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.summaryCellIdentifier) as? SummaryTableViewCell {
            
            summaryCell.summary = self.curriculum.summary
            
            return summaryCell
        }
        
        let summaryCell = SummaryTableViewCell()
        summaryCell.summary = self.curriculum.summary
        
        return summaryCell
    }
    
    private func getJobCell(_ tableView: UITableView, forRow row: Int) -> UITableViewCell {
        if let jobCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.jobCellIdentifier) as? JobDescriptionTableViewCell {
            
            jobCell.job = self.curriculum.employmentHistory?[row]
            
            return jobCell
        }
        
        let jobCell = JobDescriptionTableViewCell()
        jobCell.job = self.curriculum.employmentHistory?[row]
        
        return jobCell
    }
    
    private func getCourseCell(_ tableView: UITableView, forRow row: Int) -> UITableViewCell {
        if let courseCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.courseCellIdentifier) as? CourseTableViewCell {
            
            courseCell.course = self.curriculum.courses?[row]
            
            return courseCell
        }
        
        let courseCell = CourseTableViewCell()
        courseCell.course = self.curriculum.courses?[row]
        
        return courseCell
    }
    
    private func getSchoolGradeCell(_ tableView: UITableView, forRow row: Int) -> UITableViewCell {
        if let schoolGradeCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.schoolCellIdentifier) as? SchoolDescriptionTableViewCell {
            
            schoolGradeCell.schoolGrade = self.curriculum.education?[row]
            
            return schoolGradeCell
        }
        
        let schoolGradeCell = SchoolDescriptionTableViewCell()
        schoolGradeCell.schoolGrade = self.curriculum.education?[row]
        
        return schoolGradeCell
    }
    
    private func getSkillCell(_ tableView: UITableView, forRow row: Int) -> UITableViewCell {
        if let skillCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.skillCellIdentifier) as? SkillTableViewCell {
            
            skillCell.skill = self.curriculum.skills?[row]
            
            return skillCell
        }
        
        let skillCell = SkillTableViewCell()
        skillCell.skill = self.curriculum.skills?[row]
        
        return skillCell
    }
    
    private func getLanguageCell(_ tableView: UITableView, forRow row: Int) -> UITableViewCell {
        if let languageCell = tableView.dequeueReusableCell(withIdentifier: CVStorage.languageCellIdentifier) as? SkillTableViewCell {
            
            languageCell.skill = self.curriculum.languages?[row]
            
            return languageCell
        }
        
        let languageCell = SkillTableViewCell()
        languageCell.skill = self.curriculum.languages?[row]
        
        return languageCell
    }
}


