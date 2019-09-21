//
//  CV_ViewerUITests.swift
//  CV ViewerUITests
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import XCTest

class CV_ViewerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }


    func testSectionsAreCreated() {
        let app = XCUIApplication()
        if !app.waitForExistence(timeout: 30) {
            XCTFail()
            return
        }
        let table = app.tables
        let profileCell = table.cells.containing(.staticText, identifier: "Jose Enrique Montañez Villanueva").element
        XCTAssertTrue(profileCell.exists)
        profileCell.swipeUp()
        
        let secondJobCell = table.cells.containing(.staticText, identifier: "January 2018 – August 2018").element
        XCTAssertTrue(secondJobCell.exists)
        secondJobCell.swipeUp()
        secondJobCell.swipeUp()
        
        let lastJobCell = table.cells.containing(.staticText, identifier: "June 2019 – Present").element
        XCTAssertTrue(lastJobCell.exists)
        lastJobCell.swipeUp()
        
        let educationCell = table.cells.containing(.staticText, identifier: "Computer Engineer, Facultad de Ingeniería Eléctrica, Universidad Michoacana de San Nicolás de Hidalgo, Morelia, Mich, MX").element
        XCTAssertTrue(educationCell.exists)
        educationCell.swipeUp()
        
        let certificateCell = table.cells.containing(.staticText, identifier: "Curso completo de Core Data en Swift - Persistencia de datos, Udemy").element
        XCTAssertTrue(certificateCell.exists)
        certificateCell.tap()
        
        sleep(5)
        
        app.activate()
        
        certificateCell.swipeUp()
        
        let skillCell = table.cells.containing(.staticText, identifier: "iOS Development").element
        XCTAssertTrue(skillCell.exists)
        skillCell.swipeUp()
        
        let languajeCell = table.cells.containing(.staticText, identifier: "English").element
        XCTAssertTrue(languajeCell.exists)
        languajeCell.swipeDown()
    }

}
