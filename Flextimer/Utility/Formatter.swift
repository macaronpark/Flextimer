//
//  Formatter.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

enum Formatter {
  
  enum Text {
    static let FMT_SHM = "FMT_SHM".localized
    static let FMT_AM = "FMT_AM".localized
    static let FMT_PM = "FMT_PM".localized
    static let FMT_DAY = "FMT_DAY".localized
    static let FMT_DAY_TIME = "FMT_DAY_TIME".localized
    static let FMT_YYYYMM = "FMT_YYYYMM".localized
  }
  
  /// '오전 0시 0분'
  static var shm: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = Text.FMT_SHM
    dateFormatter.amSymbol = Text.FMT_AM
    dateFormatter.pmSymbol = Text.FMT_PM
    return dateFormatter
  }
  
  static var dayName: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = Text.FMT_DAY
    return dateFormatter
  }
  
  static var dateWithTime: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = Text.FMT_DAY_TIME
    dateFormatter.amSymbol = Text.FMT_AM
    dateFormatter.pmSymbol = Text.FMT_PM
    return dateFormatter
  }
  
  static var yyyyMM: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = Text.FMT_YYYYMM
    return dateFormatter
  }
}
