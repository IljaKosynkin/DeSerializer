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
        return Wrapped.self as! AnyClass
    }
}

extension ImplicitlyUnwrappedOptional: Typeable {
    public static func getType() -> AnyClass {
        return Wrapped.self as! AnyClass
    }
}

extension Array: Typeable {
    public static func getType() -> AnyClass {
        return Element.self as! AnyClass
    }
}
