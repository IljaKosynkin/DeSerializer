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
    
    override func getFields(_ forClass: AnyClass!) -> [AnyHashable : Any]! {
        var fields = super.getFields(forClass)
        
        let mirror = Mirror(reflecting: forClass)
        for child in mirror.children {
            if fields?[child.label!] == nil {
                if let type = type(of: child.value) as? Typeable.Type {
                    fields?[child.label!] = NSStringFromClass(type.getType())
                }
            }
        }
        
        return fields
    }
}
