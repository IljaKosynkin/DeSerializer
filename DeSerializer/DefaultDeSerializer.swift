//
//  DefaultDeSerializer.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 1/30/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

public class DefaultDeSerializer: KLPStandardDeserializer, DeSerializerProtocol {
    
    public required override init() {
        super.init()
        retriever = SwiftyFieldsRetriever()
        extractor = SwiftyArrayTypeExtractor()
    }
    
    public func deserialize<T: KLPDeserializable>(json: [String: Any]) -> T? {
        return super.deserialize(T.self, json: json) as? T
    }
    
    public func add<Out: AnyObject>(converter: KLPValueConverter, fieldName: String, type: Type, output: Out.Type) {
        super.add(converter, forField: fieldName, forInputType: type, forOutputClass: output)
    }
    
    public func add<In: AnyObject, Out: AnyObject>(converter: KLPValueConverter, fieldName: String, input: In.Type, output: Out.Type) {
        super.addValueConverter(forCustomClass: converter, forField: fieldName, forCustomClass: input, forOutputClass: output)
    }
    
    public func add<In: AnyObject, Out: AnyObject>(fieldName: String, converterClosure: @escaping (In) -> Out) {
        let converter = ClosureValuesConverter(closure: converterClosure)
        super.addValueConverter(forCustomClass: converter, forField: fieldName, forCustomClass: In.self, forOutputClass: Out.self)
    }
}
