//
//  BudgetBunnyUITests.swift
//  BudgetBunnyUITests
//
//  Created by Kiefer Yap on 4/6/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class BudgetBunnyUITests: XCTestCase {
    
    var app = XCUIApplication();
        
    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testScreenTransitions() {
        XCTAssertTrue(true)
    }
    
}