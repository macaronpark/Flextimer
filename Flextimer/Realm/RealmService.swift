//
//  RealmService.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
  
  private init() {}
  static let shared = RealmService()
  
  var realm = try! Realm()
  
  func create<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.add(object)
        Log.complete("realm.create \(object)")
      }
    } catch {
      Log.err(error)
    }
  }
  
  func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
    do {
      try realm.write {
        for (key, value) in dictionary {
          object.setValue(value, forKey: key)
        }
        Log.complete("realm.update \(dictionary)")
      }
    } catch {
      Log.err(error)
    }
  }
  
  func delete<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.delete(object)
        Log.complete("realm.delete \(object)")
      }
    } catch {
      Log.err(error)
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
}
