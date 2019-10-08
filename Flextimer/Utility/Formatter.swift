//
//  Formatter.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

enum Formatter {
  /// '오전 0시 0분'
  static var shm: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "a h시 m분"
    dateFormatter.amSymbol = "오전"
    dateFormatter.pmSymbol = "오후"
    return dateFormatter
  }
}
