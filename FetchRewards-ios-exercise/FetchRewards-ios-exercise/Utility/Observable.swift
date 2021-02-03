//
//  Observable.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import Foundation

class Observable<T> {
    
    // MARK: - Properties
    typealias Listener = (T) -> Void
    var listner: Listener?
    var value: T {
      didSet {
        listner?(value)
      }
    }
    
    init(_ value: T) {
      self.value = value
    }
    
    // MARK: - Method
    func bind(listner: Listener?) {
      self.listner = listner
      listner?(value)
    }
    
}
