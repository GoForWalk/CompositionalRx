//
//  CObservable.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import Foundation

final class CObservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset: ", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
    
}
