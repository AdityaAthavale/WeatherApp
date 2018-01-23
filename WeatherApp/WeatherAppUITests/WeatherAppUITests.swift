//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Aditya Athavale on 1/22/18.
//  Copyright © 2018 Aditya Athavale. All rights reserved.
//

import XCTest

class WeatherAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCityWithoutSpace() {

        let app = XCUIApplication()
        let enterUsCityTextField = app.textFields["Enter US City"]
        XCTAssertTrue(enterUsCityTextField.exists)
        XCTAssertTrue(app.buttons["Fetch Weather"].exists)

        enterUsCityTextField.tap()
        enterUsCityTextField.typeText("Boston")
        app.buttons["Fetch Weather"].tap()

        XCTAssertFalse(enterUsCityTextField.exists)
        XCTAssertFalse(app.buttons["Fetch Weather"].exists)

        XCTAssertTrue(app.staticTexts["Temperature :"].exists)
        XCTAssertTrue(app.staticTexts["Pressure :"].exists)
        XCTAssertTrue(app.staticTexts["Humidity :"].exists)

        XCTAssertTrue( app.navigationBars["Weather"].buttons["Done"].exists)

        app.navigationBars["Weather"].buttons["Done"].tap()

        XCTAssertFalse(app.staticTexts["Temperature"].exists)
        XCTAssertFalse(app.staticTexts["Pressure"].exists)
        XCTAssertFalse(app.staticTexts["Humidity"].exists)

        XCTAssertTrue(enterUsCityTextField.exists)
        XCTAssertTrue(app.buttons["Fetch Weather"].exists)

    }

    func testCityWithSpace() {

        let app = XCUIApplication()
        let enterUsCityTextField = app.textFields["Enter US City"]
        XCTAssertTrue(enterUsCityTextField.exists)
        XCTAssertTrue(app.buttons["Fetch Weather"].exists)

        enterUsCityTextField.tap()
        enterUsCityTextField.typeText("New York")
        app.buttons["Fetch Weather"].tap()

        XCTAssertFalse(enterUsCityTextField.exists)
        XCTAssertFalse(app.buttons["Fetch Weather"].exists)

        XCTAssertTrue(app.staticTexts["Temperature :"].exists)
        XCTAssertTrue(app.staticTexts["Pressure :"].exists)
        XCTAssertTrue(app.staticTexts["Humidity :"].exists)

        XCTAssertTrue( app.navigationBars["Weather"].buttons["Done"].exists)

        app.navigationBars["Weather"].buttons["Done"].tap()

        XCTAssertFalse(app.staticTexts["Temperature"].exists)
        XCTAssertFalse(app.staticTexts["Pressure"].exists)
        XCTAssertFalse(app.staticTexts["Humidity"].exists)

        XCTAssertTrue(enterUsCityTextField.exists)
        XCTAssertTrue(app.buttons["Fetch Weather"].exists)

    }

    func testNonUSCity() {

        let app = XCUIApplication()
        let enterUsCityTextField = app.textFields["Enter US City"]

        XCTAssertTrue(enterUsCityTextField.exists)
        XCTAssertTrue(app.buttons["Fetch Weather"].exists)

        enterUsCityTextField.tap()
        enterUsCityTextField.typeText("Pune")
        app.buttons["Fetch Weather"].tap()

        XCTAssertFalse(enterUsCityTextField.exists)
        XCTAssertFalse(app.buttons["Fetch Weather"].exists)

        XCTAssertTrue(app.alerts["Error"].exists)
        app.alerts["Error"].buttons["OK"].tap()

        XCTAssertTrue(enterUsCityTextField.exists)
        XCTAssertTrue(app.buttons["Fetch Weather"].exists)
    }
    
}
