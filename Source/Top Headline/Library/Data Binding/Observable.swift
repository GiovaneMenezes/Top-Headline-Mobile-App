//
//  Observable.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

class Observable<T> {
    private var _value: T
    var didChange: ((T) -> Void)?
    
    init(_ value: T) {
        _value = value
    }
    
    var value: T {
        get {
            return _value
        }
        set {
            _value = newValue
            didChange?(_value)
        }
    }
}
