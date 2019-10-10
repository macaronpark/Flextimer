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
    /// 이 주의 근태에 사용되는 '0시간 0분 0초' 형태 (생략 없음)
    case week
  }
  
  func toString(_ option: TimeOption) -> String {
    // reference:
    // https://stackoverflow.com/questions/28872450/conversion-from-nstimeinterval-to-hour-minutes-seconds-milliseconds-in-swift
    let time = NSInteger(self)
    let seconds = time % 60
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    
    // seconds format %0.2d 다음에 문자를 넣지 않으면 00:00:...으로 표출되는 이슈가 있었음
    // seconds format에 공백 문자열을 추가하여 해결
    let minutesCount = String(minutes).compactMap { $0.wholeNumberValue }.count

    switch option {
      
    case .total:
      // '00:00:00' 동일한 형태로 리턴
      return String(format: " %0.2d:%0.2d:%0.2d ", hours, minutes, seconds)
      
    case .remain:
      // 분 단위가 두 자리일 경우 '0시간 00분 ' 형태로 리턴
      
      if minutesCount > 1 {
        return String(format: "%0.1d시간 %0.2d분", hours, minutes)
      }
      
      // 분 단위가 한 자리이면서 0일 경우 '0시간 ' 형태로 리턴
      if minutes == 0 {
        return String(format: "%0.1d시간", hours)
      }
      
      // 분 단위가 한 자리일 경우 '0시간 0분 ' 형태로 리턴
      return String(format: "%0.1d시간 %0.1d분", hours, minutes)
      
    case .week:
      return String(format: "%0.2d시간 %0.2d분 %0.2d초", hours, minutes, seconds)
    }
    
//    // .total일 때
//    // '00:00:00' 동일한 형태로 리턴
//    if option == .total {
//      return String(format: " %0.2d:%0.2d:%0.2d ", hours, minutes, seconds)
//    }
//
//    // .remain일 때
//    // 분 단위가 두 자리일 경우 '0시간 00분 ' 형태로 리턴
//    let minutesCount = String(minutes).compactMap { $0.wholeNumberValue }.count
//    if minutesCount > 1 {
//      return String(format: "%0.1d시간 %0.2d분", hours, minutes)
//    }
//
//    // 분 단위가 한 자리이면서 0일 경우 '0시간 ' 형태로 리턴
//    if minutes == 0 {
//      return String(format: "%0.1d시간", hours)
//    }
//
//    // 분 단위가 한 자리일 경우 '0시간 0분 ' 형태로 리턴
//    return String(format: "%0.1d시간 %0.1d분", hours, minutes)
  }
}
