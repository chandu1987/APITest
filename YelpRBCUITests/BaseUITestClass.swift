//
//  BaseUITestClass.swift
//  YelpRBCUITests
//
//  Created by Chandra Sekhar Ravi on 14/01/23.
//

import XCTest

class BaseUITestClass: XCTestCase {

    var app = XCUIApplication()

    override func setUp() {
        //Setup
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        //tear down
        app.terminate()
        super.tearDown()
    }


}
