//
//  AppDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 04/10/2019.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import RealmSwift
import Siren

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = TabBarController()
    window?.makeKeyAndVisible()
    
    self.setupSiren()
    
    self.appAppearanceCofigure()
    self.initializeRealm()
    
    //    let fileURL = FileManager.default
    //    .containerURL(forSecurityApplicationGroupIdentifier: "group.suzypark.Flextimer")!
    //    .appendingPathComponent("shared.realm")
    //    Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
    
    return true
  }
  
  private func initializeRealm() {
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
}
