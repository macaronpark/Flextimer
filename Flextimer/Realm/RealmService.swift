//
//  RealmService.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import RealmSwift

class RealmService {
  
  private init() { }
  static let shared = RealmService()
  
  var realm = try! Realm()
  
  func create<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.add(object)
        DebugPrint.complete("realm.create \(object)")
      }
    } catch {
      DebugPrint.err(error)
    }
  }
  
  func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
    do {
      try realm.write {
        for (key, value) in dictionary {
          object.setValue(value, forKey: key)
        }
        DebugPrint.complete("realm.update \(dictionary)")
      }
    } catch {
      DebugPrint.err(error)
    }
  }
  
  func delete<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.delete(object)
        DebugPrint.complete("realm.delete \(object)")
      }
    } catch {
      DebugPrint.err(error)
    }
  }
  
  /// 오늘자 기록이 있고, 해당 기록에 endDate가 없다면(근무 중 이라면) true를 반환
  func isWorking() -> Bool {
    if let todayRecord = RealmService.shared.getLatestTodayWorkRecord(),
      todayRecord.endDate == nil {
      return true
    }
    return false
  }
  
  /// Realm 내 가장 최신 기록이 오늘의 기록이라면 해당 기록을 반환
  func getLatestTodayWorkRecord() -> WorkRecord? {
    let lastRecord = RealmService
      .shared.realm.objects(WorkRecord.self)
      .sorted(byKeyPath: "date", ascending: true)
      .last
    
    let calendar = Calendar.current
    
    if let lastRecord = lastRecord,
      calendar.isDateInToday(lastRecord.date) {
      return lastRecord
    }
    return nil
  }
  
  /// Date()가 속한 주의 첫 월요일 0시를 기준으로 해당 주의 기록을 반환
  func logForThisWeek() -> [WorkRecord] {
    let records = RealmService.shared.realm.objects(WorkRecord.self)
    let arr = Array(records).filter { $0.date >= Date().getMondayThisWeek() && $0.endDate != nil }
    return arr
  }
  
  func userInfo() -> UserInfo {
    if let userInfo = RealmService.shared.realm.objects(UserInfo.self).last {
      return userInfo
    } else {
      let newUserInfo = UserInfo([0, 1, 2, 3, 4], workingHours: 9)
      return newUserInfo
    }
  }
}
