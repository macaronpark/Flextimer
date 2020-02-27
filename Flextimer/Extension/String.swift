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
  
  // tableView headerView title이 default로 all uppercase로 표출됨.
  // 첫글자만 upper로 변환해서 표출하도록 함.
  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + self.lowercased().dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}
