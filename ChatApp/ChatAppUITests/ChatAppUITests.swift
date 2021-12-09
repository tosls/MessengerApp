//
//  ChatAppUITests.swift
//  ChatAppUITests
//
//  Created by Антон Бобрышев on 08.12.2021.
//

import XCTest

class ChatAppUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let usernametfTextField = app.textFields["userNameTF"]
        let infoaboutusertfTextField = app.textFields["infoAboutUserTF"]
        
        app.navigationBars["Channels"].children(matching: .button).element(boundBy: 2).tap()
        
        usernametfTextField.tap()
        infoaboutusertfTextField.tap()
    }
}
