//
//  SpaceRepositoryTests.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 29/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import XCTest

class SpaceRepositoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testExample() {
        let rep = SpaceRepository()
        
        // TEST EMPTY
        XCTAssert(rep.isEmpty())
        
        // TEST SIZE
        XCTAssert(rep.size() == 0)
        
        // TEST ADD NEW SPACE
        do {
            try rep.add("name", TupleSpace(TupleTree()))
        } catch {
            print("Error \(error)")
        }
        XCTAssert(!rep.isEmpty())
        
        // TEST GET UKNOWN
        XCTAssert(rep.get("aspace") == nil)
        
        // TEST ADD AND GET
        do {
            try rep.add("aspace", TupleSpace(TupleTree()))
        } catch {
            print("Error \(error)")
        }
        XCTAssert(rep.get("aspace") != nil)
        
        // TEST ADD TWO SPACES WITH THE SAME NAME
        do {
            try rep.add("aspace", TupleSpace(TupleTree()))
            XCTAssert(false)
        } catch {
            print("Error \(error)")
            XCTAssert(true)
        }

        // TEST ADD AND REMOVE
        do {
            try rep.add("bspace", TupleSpace(TupleTree()))
        } catch {
            print("Error \(error)")
        }
        XCTAssert(rep.get("bspace") != nil)
        _ = rep.remove("bspace")
        XCTAssert(rep.get("bspace") == nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
