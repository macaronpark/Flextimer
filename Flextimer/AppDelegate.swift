//
//  AppDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 04/10/2019.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.appAppearanceCofigure()
    
    let fileURL = FileManager.default
    .containerURL(forSecurityApplicationGroupIdentifier: "group.suzypark.Flextimer")!
    .appendingPathComponent("shared.realm")
    Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {

    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }
}
