//
//  TimeInterval.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

extension TimeInterval {
  /// TimeInterval을 사용하는 총 근무시간, 남은 근무시간 계산 시 toString(_:) 함수를 재사용하기 위한 enum
  enum TimeOption {
    /// 현재까지 총 근무 시간
    case total
    /// 남은 근무 시간
    case remain
    /// 이 주의 근태에서 사용되는 '0시간 0분' 형태 (초 생략)
    case week
  }
  
  func toString(_ option: TimeOption) -> String {
    let time = NSInteger(self)
    let seconds = time % 60
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    
    // seconds format %0.2d 다음에 문자를 넣지 않으면 00:00:...으로 표출되는 이슈가 있었음
    // seconds format에 공백 문자열을 추가하여 해결
    let minutesCount = String(minutes).compactMap { $0.wholeNumberValue }.count
    let hoursCount = String(hours).compactMap { $0.wholeNumberValue }.count
    
    switch option {
    case .total:
      // '00:00:00' 동일한 형태로 리턴
      return String(format: " %0.2d:%0.2d:%0.2d ", hours, minutes, seconds)
      
    case .remain, .week:
      // 0시 x분인 경우: 0시 절사
      if hours == 0, minutes != 0 {
        return String(format: "%0.\(minutesCount)d분", minutes)
      }
      // x시 0분인 경우: 0분 절사
      if hours != 0, minutes == 0 {
        return String(format: "%0.\(hoursCount)d시간", hours)
      }
      return String(format: " %0.\(hoursCount)d시간 %0.\(minutesCount)d분", hours, minutes)
    }
  }
}
