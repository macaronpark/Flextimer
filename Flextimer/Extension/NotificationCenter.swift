//
//  NotificationCenter.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

typealias RNotiKey = NSNotification.Name

extension NSNotification.Name {
  
  /// - options: 일일 근무 시간, 주 당 근무 요일 수, 주 당 총 근무 시간
  static let didUpdateOptions = NSNotification.Name("didUpdateOptions")
  static let didUpdateHourOfWorkhoursADay = NSNotification.Name("didUpdateHourOfWorkhoursADay")
  static let didUpdateMinuteOfWorkhoursADay = NSNotification.Name("didUpdateMinuteOfWorkhoursADay")
}
