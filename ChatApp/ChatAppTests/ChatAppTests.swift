//
//  ChatAppTests.swift
//  ChatAppTests
//
//  Created by Антон Бобрышев on 09.12.2021.
//

import XCTest
@testable import ChatApp

class ChatAppTests: XCTestCase {
    
    var gcdValidator: UserProfileManagerProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        gcdValidator = GCDManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        gcdValidator = nil
    }

    func testValidatorCorrectLoadUserProfiileFromFileManager() throws {
        
        let expectedResult = true
        var validateResult: Bool?
        
        gcdValidator?.loadUserProfile(completion: { userProfile in
            if userProfile.userName != nil && userProfile.userInfo != nil {
                validateResult = true
            } else {
                validateResult = false
            }
        })
        XCTAssertEqual(expectedResult, validateResult)
    }
    
    func testValidatorCorrectSaveUserProfileInFileManager() throws {
        let expectedResult = true
        var validateResult: Bool?
        
        let userProfileForTess = UserProfileModel(userName: "User Name", userInfo: "User Info")
        
        gcdValidator?.saveUserProfileSettings(userData: userProfileForTess, completion: { result in
            validateResult = result
        })
        XCTAssertEqual(expectedResult, validateResult)
    }

    func testPerformanceExample() throws {
        measure {
        }
    }

}
