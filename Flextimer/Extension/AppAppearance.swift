//
//  AppDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {

  func appAppearanceCofigure() {
    UINavigationBar.appearance().tintColor = Color.immutableOrange
    
    UITabBar.appearance().barTintColor = Color.systemBackground
    UITabBar.appearance().tintColor = Color.immutableOrange
    UITabBar.appearance().isTranslucent = false
  }
}
