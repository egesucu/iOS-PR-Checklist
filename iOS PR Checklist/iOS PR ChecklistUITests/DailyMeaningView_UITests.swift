//
//  DailyMeaningView_UITests.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 1.09.2025.
//

import XCTest

@MainActor
final class DailyMeaningView_UITests: XCTestCase {
    
    func test_DailyMeaning_loadingAppears() {
        let app = XCUIApplication()
        app.launch()

        // Open the sheet
        let openButton = app.buttons["daily_button"]
        XCTAssertTrue(openButton.waitForExistence(timeout: 2))
        openButton.tap()

        // Loading state should appear
        let loadingTitle = app.staticTexts["daily_title_loading"]
        XCTAssertTrue(loadingTitle.waitForExistence(timeout: 2))

        let spinner = app.descendants(matching: .any)["daily_progress"]
        XCTAssertTrue(spinner.waitForExistence(timeout: 5))
    }

    func test_DailyMeaning_sheetPresentsAndHasContainer() {
        let app = XCUIApplication()
        app.launch()

        // Open the sheet
        let openButton = app.buttons["daily_button"]
        XCTAssertTrue(openButton.waitForExistence(timeout: 2))
        openButton.tap()

        // Either loading or loaded title should exist eventually
        let loadedTitle = app.staticTexts["daily_title_loaded"]
        let loadingTitle = app.staticTexts["daily_title_loading"]
        XCTAssertTrue(loadedTitle.waitForExistence(timeout: 15) || loadingTitle.waitForExistence(timeout: 1))
    }
}
