//
//  Ancestor.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 4/11/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

open class Ancestor: NSObject, KLPDeserializable {
    required override public init() {
        super.init()
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
