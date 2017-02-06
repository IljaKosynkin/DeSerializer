//
//  SwiftyFieldsRetriever.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 1/30/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

class SwiftyFieldsRetriever: KLPDefaultFieldsRetriever {
    override func getFields(_ object: Any!) -> [AnyHashable : Any]! {
        var fields = super.getFields(object)
        
        let mirror = Mirror(reflecting: object)
        for child in mirror.children {
            if fields?[child.label!] == nil {
                if let type = type(of: child.value) as? Typeable.Type {
                    fields?[child.label!] = type.getType()
                }
            }
        }
        
        return fields
    }
}
