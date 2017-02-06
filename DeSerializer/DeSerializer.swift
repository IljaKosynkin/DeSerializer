//
//  DeSerializer.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 1/31/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

public class DeSerializer: NSObject {
    private static var defaultDeserializer: DeSerializerProtocol = DefaultDeSerializer()
    private static var alreadySet = false
    
    public static func deserialize<T: KLPDeserializable>(json: String) -> T {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        return KLPDeserializer.deserialize(withString: T.self, jsonString: json) as! T
    }
    
    public static func deserialize<T: KLPDeserializable>(json: String) -> [T] {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        return KLPDeserializer.deserialize(withString: T.self, jsonString: json) as! [T]
    }
    
    public static func deserialize<T: KLPDeserializable>(json: [[String: Any]]) -> [T] {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        return KLPDeserializer.deserialize(withArray: T.self, array: json) as! [T]
    }
    
    public static func deserialize<T: KLPDeserializable>(json: [String: Any]) -> T {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        return KLPDeserializer.deserialize(withDictionary: T.self, jsonDictionary: json) as! T
    }
    
    private static func getPointer<T>(type: T.Type?) -> AutoreleasingUnsafeMutablePointer<AnyClass?>? {
        guard let type = type else { return nil }
        
        var cls: AnyClass = type as! AnyClass
        return AutoreleasingUnsafeMutablePointer<AnyClass?>.init(&cls)
    }
    
    public static func deserialize<T: KLPDeserializable, Context: KLPDeserializable>(json: [String: Any], forField: String, inContext: Context.Type?) -> T {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        return KLPDeserializer.deserializeWithDictionary(forField: T.self, jsonDictionary: json, field: forField, context: getPointer(type: inContext)) as! T
    }
    
    public static func setDefaultDeserializer(deserializer: DeSerializerProtocol) -> DeSerializer.Type {
        defaultDeserializer = deserializer
        KLPDeserializer.setDefault(defaultDeserializer)
        
        return DeSerializer.self
    }
    
    public static func registerDeserializer<Context: KLPDeserializable>(deserializer: DeSerializerProtocol, forField: String, forContext: Context.Type?) -> DeSerializer.Type {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        var pointer: AutoreleasingUnsafeMutablePointer<KLPDeserializable.Type?>!
        if let type = forContext {
            var cls: KLPDeserializable.Type = type
            pointer = AutoreleasingUnsafeMutablePointer<KLPDeserializable.Type?>.init(&cls)
        }
        KLPDeserializer.register(deserializer, name: forField, context: pointer)
        
        return DeSerializer.self
    }
    
    public static func addValueConverter<Out>(converter: KLPValueConverter, fieldName: String?, type: Type, output: Out.Type?)  -> DeSerializer.Type {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        defaultDeserializer.addValueConverter(converter: converter, fieldName: fieldName, type: type, output: output)
        
        return DeSerializer.self
    }
    
    public static func addValueConverter<In, Out>(converter: KLPValueConverter, fieldName: String?, input: In.Type?, output: Out.Type?) -> DeSerializer.Type {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        defaultDeserializer.addValueConverter(converter: converter, fieldName: fieldName, input: input, output: output)
        return DeSerializer.self
    }
    
    public static func addValueConverter<In, Out>(fieldName: String?, converterClosure: @escaping (In) -> Out) -> DeSerializer.Type {
        if !alreadySet { KLPDeserializer.setDefault(defaultDeserializer); alreadySet = true }
        defaultDeserializer.addValueConverter(fieldName: fieldName, converterClosure: converterClosure)
        return DeSerializer.self
    }
}
