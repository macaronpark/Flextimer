//
//  Date.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

extension Date {

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }
  
  func getWeekdaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US")
    return calendar.weekdaySymbols
  }
  
  // https://stackoverflow.com/questions/33397101/how-to-get-mondays-date-of-the-current-week-in-swift
  
  func getMondayThisWeek() -> Date {
    let monday = Weekday.monday.rawValue
    let weekdaysName = Date().getWeekdaysInEnglish().map { $0.lowercased() }
    let searchWeekdayIndex = weekdaysName.firstIndex(of: monday)! + 1
    let calendar = Calendar(identifier: .gregorian)
    
    if calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }
    
    var nextDateComponent = DateComponents()
    nextDateComponent.weekday = searchWeekdayIndex
    
    let date = calendar.nextDate(
      after: self,
      matching: nextDateComponent,
      matchingPolicy: .nextTime,
      direction: .backward)
    
    return date!
  }
}
