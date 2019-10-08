//
//  TimeInterval.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

extension TimeInterval {
  // https://stackoverflow.com/
  // questions/28872450/conversion-from-nstimeinterval-to-hour-minutes-seconds-milliseconds-in-swift
  func toReadableString() -> String {
    let time = NSInteger(self)
    let seconds = time % 60
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    // seconds format %0.2d 다음에 문자를 넣지 않으면 00:00:...으로 표출되는 이슈가 있었음
    // seconds format에 공백 문자열을 추가하여 이슈 해결
    return String(format: "%0.2d:%0.2d:%0.2d ",hours,minutes,seconds)
  }
}
