//
//  RemoteSpaceTests.swift
//  SwiftSpaces
//
//  Created by Federico Ciardi on 29/08/17.
//  Copyright © 2017 Virtual. All rights reserved.
//

import XCTest

class RemoteSpaceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        // TEST KEEP CREATION
        let sr = SpaceRepository()
        sr.addGate("tcp://127.0.0.1:9090/?keep")
        let ts = TupleSpace(TupleTree())
        do {
            try sr.add("target", ts)
        } catch {
            print("Error \(error)")
        }
        
        
        // TEST KEEP USE
        let rs = RemoteSpace("tcp://127.0.0.1:9090/target?keep")
        XCTAssert(rs.put([5,4]))
        let template = [5,4]
        XCTAssert(ts.queryp(template).count != 0)
        XCTAssert(rs.query(template).count != 0)
        XCTAssert(ts.queryp([5,6]).count == 0)
        XCTAssert(ts.put([5,6,7]))
        XCTAssert(rs.get([5,6,7]).count != 0)
        XCTAssert(ts.getp([5,6,7]).count == 0)
        
        //TEST CONN USE
        let sr2 = SpaceRepository()
        sr2.addGate("tcp://127.0.0.1:9091/?conn")
        let ts2 = TupleSpace(TupleTree())
        do {
            try sr2.add("target", ts2)
        } catch {
            print("Error \(error)")
        }
        let rs2 = RemoteSpace("tcp://127.0.0.1:9091/target?conn")
        XCTAssert(rs2.put([5,4]))
        let template2 = [5,4]
        XCTAssert(ts2.queryp(template2).count != 0)
        XCTAssert(rs2.query(template2).count != 0)
        XCTAssert(ts2.queryp([5,6]).count == 0)
        XCTAssert(ts2.put([5,6,7]))
        XCTAssert(rs2.get([5,6,7]).count != 0)
        XCTAssert(ts2.getp([5,6,7]).count == 0)
        
        // TEST CONCURRENT KEEP 1
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
