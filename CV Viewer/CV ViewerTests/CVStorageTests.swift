//
//  CV_ViewerTests.swift
//  CV ViewerTests
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import XCTest
@testable import CV_Viewer

class CVStorageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let localCV = Bundle.main.url(forResource: "CV", withExtension: "json")?.absoluteString
        let parseExpectation = expectation(description: "Get and parse the CV's data")
        CVStorage.shared.fetchAndParseCV(from: localCV, completion: {
            parseExpectation.fulfill()
        }) { (error) in
            parseExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testDownloadAndParseCV() {
        XCTAssertNotNil(CVStorage.shared.getCVCollection(), "The parse failed")
    }
    
    func testCollectionHasExpectedItems() {
        XCTAssert(CVStorage.shared.getCVCollection()?.count == 1, "CV Collection didn't have the expected number of cvs")
    }
    
    func testFirstCVMainValues() {
        if let firstCV = CVStorage.shared.gertCVAt(index: 0) {
            XCTAssertEqual(firstCV.profile.name, "Jose Enrique Montañez Villanueva")
            XCTAssertEqual(firstCV.profile.jobTitle, "Senior iOS Developer")
            XCTAssertEqual(firstCV.details.details[0], "4432155519")
        } else {
            XCTFail()
        }
    }
    
    func testNumberOfExpectedSections() {
        if let firstCV = CVStorage.shared.gertCVAt(index: 0) {
            XCTAssert(firstCV.numberOfSections == 8, "The number of sections in the CV aren't correct")
        } else {
            XCTFail()
        }
    }
}
