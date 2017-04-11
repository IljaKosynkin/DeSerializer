//
//  PerformaceTests.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 3/17/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import XCTest
import DeSerializer
import KlappaDeSerializer

class PerformaceTests: XCTestCase {
    
    override static func setUp() {
        super.setUp()
    }
    
    func testLargeObjectParsingDict() {
        DeSerializer.setGlobalNamingStrategy(strategy: KLPExplicitNamingStrategy())
        let dict: [String: Any] = getJsonFile(name: "Large")
        self.measure {
            if let object: Large = DeSerializer.deserialize(json: dict) {
                
            }
        }
    }
}
