//
//  ListView_UITests.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 1.09.2025.
//
import XCTest

final class ListView_UITests: XCTestCase {
    
    @MainActor
    func test_ListView() {
        let app = XCUIApplication()
        app.launchArguments += ["-UITest_ListView_DemoData"]
        app.launch()

        // ⚠️ Type-agnostic lookup for ScrollView and list container
        let scroll = app.descendants(matching: .any)["items_scroll"]
        XCTAssertTrue(scroll.waitForExistence(timeout: 5))

        let listContainer = scroll.descendants(matching: .any)["items_list"]
        XCTAssertTrue(listContainer.waitForExistence(timeout: 5))

        // Title (type-agnostic)
        let title = app.descendants(matching: .any)["items_title"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))

        // Rows: find by identifier prefix anywhere in the tree
        let predicate = NSPredicate(format: "identifier BEGINSWITH %@", "item_row_")
        let rows = app.descendants(matching: .any).matching(predicate)
        XCTAssertGreaterThan(rows.count, 0)
    }
}
