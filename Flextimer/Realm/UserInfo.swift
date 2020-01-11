//
//  UserInfo.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/27.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

/// - 주당 근무 요일 인덱스, 일일 근무 시간_hour/minute
/// - primaryKey: 0로 단일 객체 유지
@objcMembers class UserInfo: Object {
  
  dynamic var id = 0
  
  /// 주당 근무 요일 인덱스 (월: 0, 화: 1...)
  let workdaysPerWeekIdxs = List<Int>()
  
  /// 일일 근무 시간_hour
  @objc dynamic var hourOfWorkhoursADay: Int = 9
  
  /// 일일 근무 시간_minute
  @objc dynamic var minuteOfWorkhoursADay: Int = 0
  
  override static func primaryKey() -> String? {
      return "id"
  }
  
  convenience init(_ workdaysPerWeekIdxs: [Int], hourOfWorkhoursADay: Int, minuteOfWorkhoursADay: Int) {
    self.init()
    
    self.workdaysPerWeekIdxs.append(objectsIn: workdaysPerWeekIdxs)
    self.hourOfWorkhoursADay = hourOfWorkhoursADay
    self.minuteOfWorkhoursADay = minuteOfWorkhoursADay
  }
}
