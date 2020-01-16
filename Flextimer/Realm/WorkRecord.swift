//
//  WorkRecord.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class WorkRecord: Object {
  
  dynamic var id = ""
  
  // 출근 date
  @objc dynamic var startDate: Date = Date()
  
  // 퇴근 date
  @objc dynamic var endDate: Date? = nil
  
  @objc dynamic var isHoliday: Bool = false
  
  override static func primaryKey() -> String? {
      return "id"
  }
  
  convenience init(_ startDate: Date, endDate: Date? = nil, isHoliday: Bool = false) {
    self.init()
    
    let comp = Calendar.current.dateComponents(
      [.year, .month, .weekOfMonth, .day],
      from: startDate
    )
    
    if let year = comp.year,
      let month = comp.month,
      let weekOfMonth = comp.weekOfMonth,
      let day = comp.day {
      // year
      let yearString = "\(year)"
      // month
      let month = "\(month)"
      let monthString = (month.count > 1) ? "\(month)": "0\(month)"
      // weekOfMonth
      let weekOfMonth = "\(weekOfMonth)"
      let weekOfMonthString = (weekOfMonth.count > 1) ? "\(weekOfMonth)": "0\(weekOfMonth)"
      // day
      let day = "\(day)"
      let dayString = (day.count > 1) ? "\(day)": "0\(day)"
      
      self.id = yearString + monthString + weekOfMonthString + dayString
    }
    self.startDate = startDate
    self.endDate = endDate
    self.isHoliday = isHoliday
  }
}
