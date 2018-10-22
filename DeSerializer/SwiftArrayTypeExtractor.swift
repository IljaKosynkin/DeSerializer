//
//  SwiftArrayTypeExtractor.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 2/5/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

class SwiftArrayTypeExtractor: NSObject, KLPArrayTypeExtractor {
    public func getType(_ forClass: KLPDeserializable.Type, forField fieldName: String!) -> AnyClass! {
        let obj = forClass.allocate()
        let mirror = Mirror(reflecting: obj!)
        if let child = mirror.children.filter({ $0.label == fieldName }).first, let type = type(of: child.value) as? Typeable.Type {
            return type.getType()
        }
        
        return nil
    }
}
