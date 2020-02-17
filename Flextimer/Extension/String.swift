//
//  String.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

extension String {
  
  var localized: String {
    return NSLocalizedString(self, value: self, comment: "")
  }
  
  func localized(with arguments: [CVarArg]) -> String {
    return String(format: self.localized, arguments: arguments)
  }
}
