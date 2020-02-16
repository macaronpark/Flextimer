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
  
//  enum Text {
//    static let HOURS_OF_WORKHOURS_PER_A_DAY = "%dhours per day".localized(with: userInfo.hourOfWorkhoursADay)
//  }
  
  // MARK: - UserInfo
  
  let userInfo: UserInfo
  
  var hourOfWorkhoursADay: String {
    return "%d hours per day".localized(with: userInfo.hourOfWorkhoursADay)
//    return "일 \(userInfo.hourOfWorkhoursADay)시간"
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
  
  var workRecordOfToday: WorkRecord?
  
  var isWorking: Bool {
    if workRecordOfToday != nil {
      return true
    }
    return false
  }
  
  /// 오늘 근무 시작 시간을 '오전 0시 0분'으로 변환한 string
  var startTime: String {
    if let workRecordOfToday = workRecordOfToday {
      return Formatter.shm.string(from: workRecordOfToday.startDate).replacingOccurrences(of: " 0분", with: "")
    }
    return "--:--"
  }
  
  var endTime: String {
    let isLessReamins = self.isLessRemainsThanWorkhoursADay()
    let isOverwork = (isLessReamins.raminsInterval ?? 0) < 0 ? true: false
    
    if isLessReamins.isLessRemains && isOverwork {
      return "🚨초과 근무 경보🚨"
    } else {
      // 기존 로직
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
        
          return Formatter.shm.string(from: m).replacingOccurrences(of: " 0분", with: "")
      }
      return "--:--"
    }
  }
  
  func isLessRemainsThanWorkhoursADay(
  ) -> (isLessRemains: Bool, raminsInterval: TimeInterval?) {
    // 지정 근무일 기준 총 근무 시간
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkhoursInterval = (h + m) * Double(RealmService.shared.userInfo.workdaysPerWeekIdxs.count)

    // 이번 주 토탈 기록
    let monday = Date().getThisWeekMonday()

    var records = [WorkRecord]()
    for i in 0...6 {
      let record = RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { record in
          let criteriaDate = Calendar.current.date(byAdding: .day, value: i, to: monday) ?? Date()
          if Calendar.current.isDate(record.startDate, inSameDayAs: criteriaDate) && record.endDate != nil {
            return true
          }
          return false
      }.last
      
      if let record = record {
        records.append(record)
      }
    }

    // 실 근무일 수 중 휴일이 아닌 수
    let workdaysRecords = records.filter { $0.isHoliday == false }
    let holidayCount = records.filter { $0.isHoliday == true }.count
    
    let recordsInterval = workdaysRecords
      .map { $0.startDate.timeIntervalSince($0.endDate ?? Date()) }
      .reduce(0, +)

    let recordsIntervalWithHoliday = -recordsInterval + ((h + m) * Double(holidayCount))
    
    // 오늘 시간
    let currentRecordInterval = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { Calendar.current.isDate($0.startDate, inSameDayAs: Date()) && $0.endDate == nil }
      .map { $0.startDate.timeIntervalSince($0.endDate ?? Date()) }
      .reduce(0, +)
    
    // 이번주 실 근무 총 인터벌
    let thisWeekWorkhoursTotalInteval = recordsIntervalWithHoliday + (-currentRecordInterval)
    // 남은 시간
    let remains = (totalWorkhoursInterval - thisWeekWorkhoursTotalInteval)
    
    print(thisWeekWorkhoursTotalInteval.toString(.remain))
    print(totalWorkhoursInterval.toString(.remain))
    print(remains.toString(.remain))

    if remains > (h + m) {
      return (false, nil)
    } else {
      return (true, (remains))
    }
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
