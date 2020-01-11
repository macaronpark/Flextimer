//
//  AppDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit
//import Siren
import RealmSwift

extension SceneDelegate {
  
//  func setupSiren() {
//    let siren = Siren.shared
//    siren.wail()
//    siren.presentationManager = PresentationManager(forceLanguageLocalization: .korean)
//    siren.presentationManager = PresentationManager(alertTintColor: Color.immutableOrange, appName: "자율출퇴근러")
//    siren.rulesManager = RulesManager(globalRules: .critical)
//  }
  
  func initializeRealm() {
    let config = Realm.Configuration(
      fileURL: Realm.Configuration.defaultConfiguration.fileURL!,
      deleteRealmIfMigrationNeeded: true
    )
    
    let realm = try! Realm(configuration: config)
    guard realm.isEmpty else { return }
    
    Logger.complete("Realm has been configured")
    //    try! realm.write {
    //      realm.add(DepartmentLibrary())
    //    }
  }

  func appAppearanceCofigure() {
    UINavigationBar.appearance().tintColor = Color.immutableOrange
  }
}
