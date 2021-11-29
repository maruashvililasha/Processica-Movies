//
//  PPublisher.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
/// Processica Publisher for emmiting values to listeners
final class PPublisher<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
    
  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
  }
}
