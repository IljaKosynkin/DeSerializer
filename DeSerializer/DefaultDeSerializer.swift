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
    
    public required init() {
        super.init()
        retriever = SwiftyFieldsRetriever()
        extractor = SwiftyArrayTypeExtractor()
    }
    
    public func deserialize<T: KLPDeserializable>(json: [String: Any]) -> T? {
        return super.deserialize(T.self, json: json) as? T
    }
     
    private func getPointer<T>(type: T.Type?) -> AutoreleasingUnsafeMutablePointer<AnyClass?>? {
        guard let type = type else { return nil }
        
        var cls: AnyClass = type as! AnyClass
        return AutoreleasingUnsafeMutablePointer<AnyClass?>.init(&cls)
    }
    
    public func addValueConverter<Out>(converter: KLPValueConverter, fieldName: String?, type: Type, output: Out.Type?) {
        let outType = getPointer(type: output)
        super.add(converter, forField: fieldName, forInputType: type, forOutputClass: outType)
    }
    
    public func addValueConverter<In, Out>(converter: KLPValueConverter, fieldName: String?, input: In.Type?, output: Out.Type?) {
        let inType = getPointer(type: input)
        let outType = getPointer(type: output)
        super.addValueConverter(forCustomClass: converter, forField: fieldName, forCustomClass: inType, forOutputClass: outType)
    }
    
    public func addValueConverter<In, Out>(fieldName: String?, converterClosure: @escaping (In) -> Out) {
        let converter = ClosureValuesConverter(closure: converterClosure)
        let inType = getPointer(type: In.self)
        let outType = getPointer(type: Out.self)
        super.addValueConverter(forCustomClass: converter, forField: fieldName, forCustomClass: inType, forOutputClass: outType)
    }
}
