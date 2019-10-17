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
  
  func isWorking() -> Bool {
    let isEmpty = RealmService.shared.realm.objects(WorkRecord.self)
      .filter { $0.endDate == nil }
      .isEmpty
    
    if isEmpty {
      return false
    } else {
      return true
    }
  }
  
  /// Realm 내 가장 최신 기록이 오늘의 기록이라면 해당 기록을 리턴한다
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
  
  func logForThisWeek() -> [WorkRecord] {
    let records = RealmService.shared.realm.objects(WorkRecord.self)
    let arr = Array(records).filter { $0.date >= Date().getMondayThisWeek() && $0.endDate != nil }
    return arr
  }
}
