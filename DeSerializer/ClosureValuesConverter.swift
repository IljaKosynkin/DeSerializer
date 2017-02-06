//
//  ClosureValuesConverter.swift
//  DeSerializer
//
//  Created by Ilja Kosynkin on 1/31/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

import Foundation
import KlappaDeSerializer

class ClosureValuesConverter<In, Out>: NSObject, KLPValueConverter {
    private let closure: (In) -> Out
    
    init(closure: @escaping (In) -> Out) {
        self.closure = closure
        super.init()
    }
    
    required init() {
        fatalError("Not supposed to be called")
    }
    
    func convert(_ value: Any!) -> Any! {
        let converted: Out = self.closure(value as! In)
        return converted
    }
}
