//
//  Int.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

extension Int {
  
  enum TimeType {
    case hour
    case minute
  }
  
  /// 시간(hour)의 크기를 나타내는 Int를 TimeInterval.rounded()로 리턴
  func toRoundedTimeInterval(_ type: TimeType) -> TimeInterval {
    if type == .hour {
      return TimeInterval(self * 60 * 60).rounded()
    }
    return TimeInterval(self * 60).rounded()
  }
}
