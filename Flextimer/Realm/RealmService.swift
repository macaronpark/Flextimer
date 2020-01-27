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
}
