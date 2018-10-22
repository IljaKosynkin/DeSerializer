//
//  Ancestor.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 4/11/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

public protocol IAncestor: KLPDeserializable {
    static func create() -> Self
}

@objc
open class Ancestor: NSObject, IAncestor {
    open class func create() -> Self {
        fatalError("Implement this function")
    }
    
    public static func allocate() -> KLPDeserializable {
        return self.create()
    }
    
    open class func getRequiredFields() -> [Any]! {
        return []
    }
    
    open class func getCustomFieldsMapping() -> [AnyHashable : Any]! {
        return [:]
    }
    
    open class func getFieldsToClassMap() -> [AnyHashable : Any]! {
        return [:]
    }
    
    open class func getNamingStrategy() -> KLPNamingStrategy? {
        return nil
    }
}
