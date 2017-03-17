//
//  CommonClasses.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 2/6/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import DeSerializer

class SimpleObject: NSObject {
    var name: String!
    var price: NSDecimalNumber!
    
    override static func getRequiredFields() -> [Any] {
        return ["name"]
    }
}

class Thumbnail: NSObject {
    var url: String!
    var height: String!
    var width: String!
}

class NestedObject: NSObject {
    var title: String!
    var summary: String!
    var url: String!
    var clickUrl: String!
    var refererUrl: String!
    var fileSize: Int = 0
    var fileFormat: String!
    var height: String!
    var width: String!
    var thumbnail: Thumbnail!
}

class Address: NSObject {
    var streetAddress: String!
    var city: String!
    var state: String!
    var postalCode: String!
}

class Phone: NSObject {
    var type: String!
    var number: String!
}

class NestedObjectWithArray: NSObject {
    var firstName: String!
    var lastName: String!
    var age: Int = 0
    var address: Address!
    var phoneNumber: [Phone] = []
}

func getJsonString(name: String) -> String {
    let filepath = Bundle.init(for: NestedObject.self as AnyClass).path(forResource: name, ofType: "json")
    let content = try? String.init(contentsOfFile: filepath!)
    return content!
}

func getJsonFile(name: String) -> [String: Any]  {
    let content = getJsonString(name: name)
    let data = content.data(using: .utf8)
    let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
    return dict as! [String: Any]
}

func getJsonFile(name: String) -> [[String: Any]]  {
    let content = getJsonString(name: name)
    let data = content.data(using: .utf8)
    let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
    return dict as! [[String: Any]]
}
