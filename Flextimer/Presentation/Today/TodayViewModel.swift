//
//  TodayViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

import RxSwift

class TodayViewModel {
  
  // MARK: - UserInfo
  
  let userInfo: UserInfo
  
  var hourOfWorkhoursADay: String {
    return "일 \(userInfo.hourOfWorkhoursADay)시간"
  }
  var minuteOfWorkhoursADay: String {
    if (userInfo.minuteOfWorkhoursADay == 0) {
      return ""
    }
    return " \(userInfo.minuteOfWorkhoursADay)분"
  }
  var numberOfWorkdaysAWeek: String {
    return "주 \(userInfo.workdaysPerWeekIdxs.count)일"
  }
  var totalWorkhours: String {
    return self.totalWorkhoursString()
  }
  
  
  // MARK: - WorkRecord
  
  let workRecordOfToday: WorkRecord?
  
  var isWorking: Bool {
    if workRecordOfToday != nil {
      return true
    }
    return false
  }
  
  /// 오늘 근무 시작 시간을 '오전 0시 0분'으로 변환한 string
  var startTime: String {
    if let workRecordOfToday = workRecordOfToday {
      return Formatter.shm.string(from: workRecordOfToday.startDate)
    }
    return "--:--"
  }
  
  var endTime: String {
    if let workRecordOfToday = workRecordOfToday {
      let h = Calendar.current.date(
        byAdding: .hour,
        value: self.userInfo.hourOfWorkhoursADay,
        to: workRecordOfToday.startDate
        ) ?? Date()
      
      let m = Calendar.current.date(
        byAdding: .minute,
        value: self.userInfo.minuteOfWorkhoursADay,
        to: h
        ) ?? Date()
      
        return Formatter.shm.string(from: m)
    }
    return "--:--"
  }
  
  
  // MARK: - Init
  
  init(_ userInfo: UserInfo, workRecordOfToday: WorkRecord?) {
    self.userInfo = userInfo
    self.workRecordOfToday = workRecordOfToday
  }
  
  fileprivate func totalWorkhoursString() -> String {
    let hour = self.userInfo.hourOfWorkhoursADay
    let minute = self.userInfo.minuteOfWorkhoursADay
    let numberOfWorkdays = self.userInfo.workdaysPerWeekIdxs.count
    
    let multipledHour = hour * numberOfWorkdays
    let multipledMinute = minute * numberOfWorkdays

    let shareOfmultipledMinute: Int = multipledMinute / 60
    let restOfmultipledMinute: Int = multipledMinute % 60
    
    let hourResult = multipledHour + shareOfmultipledMinute
    let minuteResult = restOfmultipledMinute
    
    if minute == 0 {
      return "\(hourResult)시간 기준"
    }
    return "\(hourResult)시간 \(minuteResult)분 기준"
  }
}
