//
//  LoginScreenTests.swift
//  LoginScreenTests
//
//  Created by Admin on 18/08/21.
//

import XCTest
@testable import LoginScreen

class LoginScreenTests: XCTestCase {

    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testStoreApiResponse() throws {
        
        let vc = StoreViewModel()
        
        let expect = expectation(description: "Completion handler invoked with code status code 200")
        var productCount: Int? = 0
        vc.fetchStoreData(category: "electronics") { isFinished, data in
            
            if isFinished {
                debugPrint("Finished in unit test!!!")
            productCount = data?.count
                expect.fulfill()
                
            }
            
        }
        wait(for: [expect], timeout: 100)
        
        XCTAssert(productCount! > 0, "API FAIL -  ...Successful API with Product List.")
        
    }
    
}
