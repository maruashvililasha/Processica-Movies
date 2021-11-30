//
//  PPublisher.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

/// Processica Publisher for emmiting values to listeners (I just avoided to use Combine or RxSwift)
final class PPublisher<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
    
    func accept(_ value: T) {
        self.value = value
        listener?(value)
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
