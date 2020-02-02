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
    
    // schemaVersion 5: UserInfo-isTutorialSeen property 추가
    let config = Realm.Configuration(
      fileURL: fileURL,
      schemaVersion: 5,
      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < 5) {
          migration.enumerateObjects(ofType: UserInfo.className()) { oldObject, newObject in
            newObject!["isTutorialSeen"] = false
          }
        }
    })
    
    Realm.Configuration.defaultConfiguration = config
    
    do {
      let _ = try Realm(configuration: config)
      Logger.complete("Realm has been configured")
    } catch let error as NSError {
      Logger.debug(error.localizedDescription)
    }
  }
}
