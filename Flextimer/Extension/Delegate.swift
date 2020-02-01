//
//  AppDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension AppDelegate {

  func initializeRealm() {
    
    let fileURL = FileManager.default
    .containerURL(forSecurityApplicationGroupIdentifier: "group.suzypark.Flextimer")!
    .appendingPathComponent("shared.realm")
    Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
    
    // version 2: [UserInfo]-[isTutorialSeen] property 추가
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
      schemaVersion: 2,
      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < 2) {
          migration.enumerateObjects(ofType: UserInfo.className()) { oldObject, newObject in
            newObject!["isTutorialSeen"] = false
          }
        }
    })
    
    do {
      let _ = try Realm(configuration: Realm.Configuration.defaultConfiguration)
      Logger.complete("Realm has been configured")
    } catch let error as NSError {
      Logger.debug(error.localizedDescription)
    }
  }
}
