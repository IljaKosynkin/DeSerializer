//
//  DeSerializer.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 1/30/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

public protocol DeSerializerProtocol: KLPDeserializerProtocol {
    func deserialize<T: KLPDeserializable>(json: [String: Any]) -> T
    func addValueConverter<Out>(converter: KLPValueConverter, fieldName: String?, type: Type, output: Out.Type?)
    func addValueConverter<In, Out>(converter: KLPValueConverter, fieldName: String?, input: In.Type?, output: Out.Type?)
    func addValueConverter<In, Out>(fieldName: String?, converterClosure: @escaping (In) -> Out)
}
