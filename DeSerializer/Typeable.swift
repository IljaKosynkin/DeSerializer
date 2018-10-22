//
//  Typeable.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 1/30/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation

public protocol Typeable {
    static func getType() -> AnyClass
}

extension Optional: Typeable {
    public static func getType() -> AnyClass {
        if let type = Wrapped.self as? Typeable.Type {
            return type.getType()
        }
        
        return Wrapped.self as! AnyClass
    }
}

extension Array: Typeable {
    public static func getType() -> AnyClass {
        if let type = Element.self as? Typeable.Type {
            return type.getType()
        }
        
        return Element.self as! AnyClass
    }
}

extension String: Typeable {
    public static func getType() -> AnyClass {
        return NSString.self
    }
}
