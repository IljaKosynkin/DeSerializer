//
//  PerformaceTests.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 3/17/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import XCTest
import DeSerializer

class PerformaceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testSimpleObjectParsingDict() {
        let dict: [String: Any] = getJsonFile(name: "SimpleObject")
        if let object: SimpleObject = DeSerializer.deserialize(json: dict) {
            XCTAssertEqual(object.name, "A green door")
            XCTAssertEqual(object.price, 12.5)
        } else {
            XCTFail()
        }
    }
    
    func testPerformaceNested() {
        let dict: [String: Any] = getJsonFile(name: "NestedObject")
        self.measure {
            let object: NestedObject? = DeSerializer.deserialize(json: dict)
        }
    }
    
    func testPerformaceNestedObjectWithArrayDict() {
        let dict: [String: Any] = getJsonFile(name: "NestedObjectWithArray")
        self.measure {
            let object: NestedObjectWithArray? = DeSerializer.deserialize(json: dict)
        }
    }
    
    func testPerformaceArrayParsingDict() {
        let array: [[String: Any]] = getJsonFile(name: "Array")
        self.measure {
            let objects: [NestedObject]? = DeSerializer.deserialize(json: array)
        }
    }
    
    
    func testPerformaceSimpleObjectParsingString() {
        let dict: String = getJsonString(name: "SimpleObject")
        self.measure {
            let object: SimpleObject? = DeSerializer.deserialize(json: dict)
        }
    }
    
    func testPerformaceNestedObjectString() {
        let dict: String = getJsonString(name: "NestedObject")
        self.measure {
            let object: NestedObject? = DeSerializer.deserialize(json: dict)
        }
    }
    
    func testPerformaceNestedObjectWithArrayString() {
        let dict: String = getJsonString(name: "NestedObjectWithArray")
        self.measure {
            let object: NestedObjectWithArray? = DeSerializer.deserialize(json: dict)
        }
    }
    
    func testPerformaceArrayParsingString() {
        let array: String = getJsonString(name: "Array")
        self.measure {
            let objects: [NestedObject]? = DeSerializer.deserialize(json: array)
        }
    }
}
