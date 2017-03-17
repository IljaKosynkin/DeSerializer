//
//  DeSerializerTests.swift
//  DeSerializerTests
//
//  Created by Ilja Kosynkin on 1/30/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import XCTest
import DeSerializer

class DefaultDeserializerTests: XCTestCase {
    private let deserializer = DefaultDeSerializer()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSimpleObjectParsing() {
        let dict: [String: Any] = getJsonFile(name: "SimpleObject")
        if let object: SimpleObject = deserializer.deserialize(json: dict) {
            XCTAssertEqual(object.name, "A green door")
            XCTAssertEqual(object.price, 12.5)
        } else {
            XCTFail()
        }
    }
    
    func testNestedObject() {
        let dict: [String: Any] = getJsonFile(name: "NestedObject")
        if let object: NestedObject = deserializer.deserialize(json: dict) {
            XCTAssertEqual(object.title, "potato jpg")
            XCTAssertEqual(object.summary, "Kentang Si bungsu dari keluarga Solanum tuberosum L ini ternyata memiliki khasiat untuk mengurangi kerutan  jerawat  bintik hitam dan kemerahan pada kulit  Gunakan seminggu sekali sebagai")
            XCTAssertEqual(object.url, "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg")
            XCTAssertEqual(object.clickUrl, "http://www.mediaindonesia.com/spaw/uploads/images/potato.jpg")
            XCTAssertEqual(object.refererUrl, "http://www.mediaindonesia.com/mediaperempuan/index.php?ar_id=Nzkw")
            XCTAssertEqual(object.fileSize, 22630)
            XCTAssertEqual(object.fileFormat, "jpeg")
            XCTAssertEqual(object.width, "532")
            XCTAssertEqual(object.height, "362")
            XCTAssertEqual(object.thumbnail.url, "http://thm-a01.yimg.com/nimage/557094559c18f16a")
            XCTAssertEqual(object.thumbnail.height, "98")
            XCTAssertEqual(object.thumbnail.width, "145")
        } else {
            XCTFail()
        }
    }
    
    func testNestedObjectWithArray() {
        let dict: [String: Any] = getJsonFile(name: "NestedObjectWithArray")
        if let object: NestedObjectWithArray = deserializer.deserialize(json: dict) {
            XCTAssertEqual(object.firstName, "John")
            XCTAssertEqual(object.lastName, "Smith")
            XCTAssertEqual(object.age, 25)
        
            XCTAssertEqual(object.address.streetAddress, "21 2nd Street")
            XCTAssertEqual(object.address.city, "New York")
            XCTAssertEqual(object.address.state, "NY")
            XCTAssertEqual(object.address.postalCode, "10021")
        
            XCTAssertEqual(object.phoneNumber.count, 2)
            XCTAssertEqual(object.phoneNumber[0].type, "home")
            XCTAssertEqual(object.phoneNumber[0].number, "212 555-1234")
            XCTAssertEqual(object.phoneNumber[1].type, "fax")
            XCTAssertEqual(object.phoneNumber[1].number, "646 555-4567")
        } else {
            XCTFail()
        }
    }
    
    
    func testShouldNotParseJsonWithoutRequiredProperty() {
        let dict: [String: Any] = getJsonFile(name: "SimpleObject3")
        let object: SimpleObject? = deserializer.deserialize(json: dict)
        
        XCTAssertNil(object)
    }
}
