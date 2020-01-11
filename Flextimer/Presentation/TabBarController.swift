//
//  TabBarController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupAppearance()
    let todayVC = TodayViewController()
    let todayNVC = UINavigationController(rootViewController: todayVC)
    todayNVC.tabBarItem = UITabBarItem(title: "오늘의 근태", image: UIImage(named: "tab_today"), tag: 0)
    
    let historyVC = HistoryViewController()
    let historyNVC = UINavigationController(rootViewController: historyVC)
    historyNVC.tabBarItem = UITabBarItem(title: "기록", image: UIImage(named: "tab_history"), tag: 0)
    
    let tabBarList = [todayNVC, historyNVC]
    viewControllers = tabBarList
  }
  
  func setupAppearance() {
    let appearance = UITabBarAppearance()
    appearance.stackedLayoutAppearance.normal.iconColor = Color.immutableLightGray
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.immutableLightGray]
    appearance.stackedLayoutAppearance.selected.iconColor = Color.immutableOrange
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.immutableOrange]
    self.tabBar.standardAppearance = appearance
  }
}
