//
//  SetupTests.swift
//  MongoKitten
//
//  Created by Joannis Orlandos on 23/03/16.
//  Copyright © 2016 PlanTeam. All rights reserved.
//

import MongoKitten
import XCTest
import Foundation

class SetupTests: XCTestCase {
    static var allTests: [(String, SetupTests -> () throws -> Void)] {
        return [
            ("testSetup", testSetup),
        ]
    }
    
    override func setUp() {
        super.setUp()

        try! TestManager.connect()
        
        try! TestManager.clean()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetup() {
        let server = try! Server("mongodb://mongokitten-unittest-user:mongokitten-unittest-password@localhost:27017", automatically: true)
        let distinct = try! server["mongokitten-unittest"]["zips"].distinct(on: "state")!
        
        XCTAssertEqual(distinct.count, 51)
    }
}