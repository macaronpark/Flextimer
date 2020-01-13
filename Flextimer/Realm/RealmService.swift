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
  
  private init() {}
  static let shared = RealmService()
  
  var realm = try! Realm()
  
  
  // MARK: - USER INFO
  
  var userInfo: UserInfo {
    let userInfoArray = self.realm.objects(UserInfo.self).filter("id == 0")
    
    guard let userInfo = userInfoArray.last else {
      let newUserInfo = UserInfo(
        [0, 1, 2, 3, 4],
        hourOfWorkhoursADay: 9,
        minuteOfWorkhoursADay: 0)
      self.create(newUserInfo)
      return newUserInfo
    }
    
    return userInfo
  }
  
  
  // MARK: - CRUD
  
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
  
  //  /// 가장 최근 기록의 endDate가 nil일 경우 근무 중으로 판단,  true를 반환
  //  func isWorking() -> Bool {
  //    let lastRecord = RealmService
  //      .shared.realm.objects(WorkRecord.self)
  //      .sorted(byKeyPath: "date", ascending: true)
  //      .last
  //
  //    if let record = lastRecord,
  //      record.endDate == nil {
  //      return true
  //    }
  //    return false
  //  }
  //
  //  func getLastWorkingRecord() -> WorkRecord? {
  //    let lastRecord = RealmService
  //      .shared.realm.objects(WorkRecord.self)
  //      .sorted(byKeyPath: "date", ascending: true)
  //      .last
  //
  //    if let record = lastRecord,
  //      record.endDate == nil {
  //      return record
  //    }
  //    return nil
  //  }
  
  //  /// 오늘의 기록을 반환
  //  func getTodayRecord() -> WorkRecord? {
  //    let lastRecord = RealmService
  //      .shared.realm.objects(WorkRecord.self)
  //      .sorted(byKeyPath: "date", ascending: true)
  //      .last
  //
  //    let calendar = Calendar.current
  //
  //    if let record = lastRecord,
  //      calendar.isDateInToday(record.date) {
  //      return record
  //    }
  //    return nil
  //  }
  //
  //  /// Date()가 속한 주의 첫 월요일 0시를 기준으로 해당 주의 기록을 반환
  //  func getThisWeekRecords() -> [WorkRecord] {
  //    var components = Calendar.current.dateComponents(
  //      [.year, .month, .day, .hour, .minute],
  //      from: Date()
  //    )
  //    components.hour = 0
  //    components.minute = 0
  //
  //    let today = Calendar.current.date(from: components) ?? Date()
  //
  //    let records = RealmService
  //      .shared.realm.objects(WorkRecord.self)
  //      .filter("date >= %@", today.getThisWeekMonday())
  //
  //    return Array(records)
  //  }
}
