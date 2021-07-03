//
//  brastewarkmobiletestTests.swift
//  brastewarkmobiletestTests
//
//  Created by alvaro Landa Hidalgo on 29/6/21.
//

import XCTest
@testable import brastewarkmobiletest

class brastewarkmobiletestTests: XCTestCase {

    func testGetInhabitant(){
        DataProvider.getInhabitant(){(data:[Inhabitant]) -> Void in
            XCTAssertNil(data)
            XCTAssertGreaterThan(data.count, 0)
            XCTAssertLessThan(data.count,0 , "Inhabitant list is empty")
        }
    }
}
