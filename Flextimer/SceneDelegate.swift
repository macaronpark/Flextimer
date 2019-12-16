//
//  SceneDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 04/10/2019.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let contentView = RootView()
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      
      window.rootViewController = UIHostingController(
        rootView: contentView.environmentObject(UserData())
      )
      
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
