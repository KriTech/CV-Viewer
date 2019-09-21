//
//  CV.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 08/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import Foundation


class CV: NSObject {
    
    let profile: Profile
    let details: Details
    let summary: String
    let employmentHistory: [Job]?
    let education: [SchoolGrade]?
    let courses: [Course]?
    let skills: [Skill]?
    let languages: [Skill]?
    private var sections = [Int: String]()
    let numberOfSections: Int
    
    init(profile: Profile, details: Details, summary: String, employmentHistory: [Job]? = nil, education: [SchoolGrade]? = nil, courses: [Course]? = nil, skills: [Skill]? = nil, languages: [Skill]? = nil) {
        self.profile = profile
        self.details = details
        self.summary = summary
        self.employmentHistory = employmentHistory
        self.education = education
        self.courses = courses
        self.skills = skills
        self.languages = languages
        
        var numberOfSections = 3
        
        numberOfSections += employmentHistory != nil ? 1 : 0
        sections[numberOfSections-1] = "jobCell"
        numberOfSections += education != nil ? 1 : 0
        sections[numberOfSections-1] = "schoolCell"
        numberOfSections += courses != nil ? 1 : 0
        sections[numberOfSections-1] = "courseCell"
        numberOfSections += skills != nil ? 1 : 0
        sections[numberOfSections-1] = "skillCell"
        numberOfSections += languages != nil ? 1 : 0
        sections[numberOfSections-1] = "languageCell"
        
        self.numberOfSections = numberOfSections
    }
    
    func numberOfItemsInSection(numberOfSection: Int) -> Int? {
        let section = self.sections[numberOfSection]
        switch section {
        case "jobCell":
            return self.employmentHistory?.count
        case "schoolCell":
            return self.education?.count
        case "courseCell":
            return self.courses?.count
        case "skillCell":
            return self.skills?.count
        case "languageCell":
            return self.languages?.count
        default:
            return 0
        }
    }
    
    func identifierForCellIn(section: Int) -> String? {
        let section = self.sections[section]
        switch section {
        case "jobCell":
            return CVStorage.jobCellIdentifier
        case "schoolCell":
            return CVStorage.schoolCellIdentifier
        case "courseCell":
            return CVStorage.courseCellIdentifier
        case "skillCell":
            return CVStorage.skillCellIdentifier
        case "languageCell":
            return CVStorage.languageCellIdentifier
        default:
            return nil
        }
    }
    
    func sectionTitle(forSection section: Int) -> String? {
        let section = self.sections[section]
        switch section {
        case "jobCell":
            return "employmentHistory".localized().capitalized
        case "schoolCell":
            return "education".localized().capitalized
        case "courseCell":
            return "certificates".localized().capitalized
        case "skillCell":
            return "skills".localized().capitalized
        case "languageCell":
            return "languages".localized().capitalized
        default:
            return nil
        }
    }
    
}
