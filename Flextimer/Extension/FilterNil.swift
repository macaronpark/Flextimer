//
//  FilterNil.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RxSwift

public protocol OptionalType {
  associatedtype Wrapped
  var value: Wrapped? { get }
}

extension Optional: OptionalType {
  /// Cast `Optional<Wrapped>` to `Wrapped?`
  public var value: Wrapped? {
    return self
  }
}

public extension ObservableType where Element: OptionalType {
  func filterNil() -> Observable<Element.Wrapped> {
    return self.flatMap { element -> Observable<Element.Wrapped> in
      guard let value = element.value else {
        return Observable<Element.Wrapped>.empty()
      }
      return Observable<Element.Wrapped>.just(value)
    }
  }
}
