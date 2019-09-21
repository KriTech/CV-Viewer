//
//  CVStorage.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 07/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit


class CVStorage: NSObject {
    
    static let shared = CVStorage()
    
    
    static let profileCellIdentifier = "profileCell"
    static let detailsCellIdentifier = "detailsCell"
    static let summaryCellIdentifier = "summaryCell"
    static let jobCellIdentifier = "jobCell"
    static let schoolCellIdentifier = "schoolCell"
    static let courseCellIdentifier = "courseCell"
    static let skillCellIdentifier = "skillCell"
    static let languageCellIdentifier = "languageCell"

    private var curriculums = [CV]()
    
    func fetchAndParseCV(from: String?, completion: @escaping () -> Void, failure: @escaping (FailureType) -> Void) {
        guard let from = from else {
            failure(.invalidURL)
            return
        }
        self.curriculums.removeAll()
        WebServices.shared.fetchCVJSON(urlString: from, completion: { (cvArray) in
            for cvInfo in cvArray {
                var profile: Profile?
                var details: Details?
                var summary: String?
                var employmentHistory: [Job]?
                var education: [SchoolGrade]?
                var courses: [Course]?
                var skills: [Skill]?
                var languages: [Skill]?
                
                for (key, value) in cvInfo {
                    switch key {
                    case "profile":
                        if let value = value as? [String: Any] {
                            profile = self.parseProfile(profileInfo: value)
                        }
                    case "details":
                        if let value = value as? [String: Any] {
                            details = self.parseDetails(detailsInfo: value)
                        }
                    case "summary":
                        if let value = value as? String {
                            summary = value
                        }
                    case "employmentHistory":
                        if let value = value as? [[String: Any]] {
                            employmentHistory = self.parseEmploymentHistory(employmentInfo: value)
                        }
                    case "education":
                        if let value = value as? [[String: Any]] {
                            education = self.parseEducation(educationInfo: value)
                        }
                    case "courses":
                        if let value = value as? [[String: Any]] {
                            courses = self.parseCourses(coursesInfo: value)
                        }
                    case "skills":
                        if let value = value as? [[String: Any]] {
                            skills = self.parseSkills(skillsInfo: value)
                            skills?.sort(by: { (lhs, rhs) -> Bool in
                                return lhs.title < rhs.title
                            })
                        }
                    case "languages":
                        if let value = value as? [String: Any] {
                            languages = self.parseLanguages(languagesInfo: value)
                            languages?.sort(by: { (lhs, rhs) -> Bool in
                                return lhs.title < rhs.title
                            })
                        }
                    default:
                        break
                    }
                }
                
                if let profile = profile, let details = details, let summary = summary {
                    self.curriculums.append(CV(profile: profile, details: details, summary: summary, employmentHistory: employmentHistory, education: education, courses: courses, skills: skills, languages: languages))
                }
            }
            completion()
        }, failure: failure)
        
    }
    
    func getCVCollection() -> [CV]? {
        if self.curriculums.count == 0 { return nil }
        return self.curriculums
    }
    
    func numberOfCurriculums() -> Int {
        return self.curriculums.count
    }
    
    func gertCVAt(index: Int) -> CV? {
        guard index >= 0 && index < self.curriculums.count else {
            return nil
        }
        return self.curriculums[index]
    }
    
    private func parseProfile(profileInfo: [String: Any]) -> Profile? {
        
        guard let name = profileInfo["name"] as? String, let jobTitle = profileInfo["jobTitle"] as? String, let imageURLString = profileInfo["profileImage"] as? String else {
            return nil
        }
        
        return Profile(name: name, jobTitle: jobTitle, imageURLString: imageURLString)
    }
    
    private func parseDetails(detailsInfo: [String: Any]) -> Details? {
        guard let phoneNumber = detailsInfo["phoneNumber"] as? String, let email = detailsInfo["email"] as? String, let nationality = detailsInfo["nationality"] as? String else {
            return nil
        }
        
        return Details(phoneNumber: phoneNumber, email: email, nationality: nationality)
    }
    
    private func parseEmploymentHistory(employmentInfo: [[String: Any]]) -> [Job]? {
        var jobs = [Job]()
        for employment in employmentInfo {
            guard let title = employment["title"] as? String, let period = employment["period"] as? String else {
               continue
            }
            jobs.append(Job(title: title, period: period, activities: employment["activities"] as? [String] ?? [] ))
        }
        if jobs.count > 0 {
            return jobs
        }
        return nil
    }
    
    private func parseEducation(educationInfo: [[String: Any]]) -> [SchoolGrade]? {
        var schoolsInfo = [SchoolGrade]()
        
        for schoolInfo in educationInfo {
            guard let title = schoolInfo["title"] as? String, let description = schoolInfo["description"] as? String, let period = schoolInfo["period"] as? String else {
                continue
            }
            schoolsInfo.append(SchoolGrade(title: title, period: period, description: description))
        }
        
        if schoolsInfo.count > 0 {
            return schoolsInfo
        }
        
        return nil
    }
    
    private func parseCourses(coursesInfo: [[String: Any]]) -> [Course]? {
        var courses = [Course]()
        
        for courseInfo in coursesInfo {
            guard let title = courseInfo["title"] as? String, let issueDate = courseInfo["issueDate"] as? String else {
                continue
            }
            courses.append(Course(name: title, issueDate: issueDate, url: courseInfo["url"] as? String))
        }
        
        if courses.count > 0 {
            return courses
        }
        
        return nil
    }
    
    private func parseSkills(skillsInfo: [[String: Any]]) -> [Skill]? {
        var skills = [Skill]()
        
        for skillInfo in skillsInfo {
            guard let title = skillInfo["title"] as? String, let level = skillInfo["percentage"] as? Int else {
                continue
            }
            skills.append(Skill(title: title, percentage: level))
        }
        if skills.count > 0 {
            return skills
        }
        return nil
    }
    
    private func parseLanguages(languagesInfo: [String: Any]) -> [Skill]? {
        var languages = [Skill]()
        
        for (key, value) in languagesInfo {
            let title = key
            if let level = value as? Int {
                languages.append(Skill(title: title, percentage: level))
            }
        }
        
        if languages.count > 0 {
            return languages
        }
        
        return nil
    }
}
