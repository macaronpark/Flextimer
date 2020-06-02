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
  
  enum Text {
    static let TAB_BAR_ITEM_1 = "Today".localized
    static let TAB_BAR_ITEM_2 = "Record".localized
  }
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupAppearance()
    
    let todayViewModel = self.todayViewModel()
    
    let todayVC = TodayViewController(todayViewModel)
    let todayNVC = UINavigationController(rootViewController: todayVC)
    todayNVC.tabBarItem = UITabBarItem(
      title: Text.TAB_BAR_ITEM_1,
      image: UIImage(named: "tab_today"), tag: 0
    )
    
    let comp = Calendar.current.dateComponents([.year, .month], from: Date())
    
    guard let year = comp.year,
      let month = comp.month else { return }
    
    let historyViewModel = HistoryViewModel(year: year, month: month)
    let historyVC = HistoryViewController(historyViewModel)
    let historyNVC = UINavigationController(rootViewController: historyVC)
    historyNVC.tabBarItem = UITabBarItem(
      title: Text.TAB_BAR_ITEM_2,
      image: UIImage(named: "tab_history"), tag: 0
    )
    
    let tabBarList = [todayNVC, historyNVC]
    viewControllers = tabBarList
  }
  
  
  // MARK: - Custom Methods
  
  fileprivate func setupAppearance() {
    let appearance = UITabBarAppearance()
    appearance.stackedLayoutAppearance.normal.iconColor = Color.immutableLightGray
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: Color.immutableLightGray
    ]
    
    appearance.stackedLayoutAppearance.selected.iconColor = Color.immutableOrange
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: Color.immutableOrange
    ]
    self.tabBar.standardAppearance = appearance
  }
  
  fileprivate func todayViewModel() -> TodayViewModel {
    let userInfo = RealmService.shared.userInfo
    
    let workRecordOfToday: WorkRecord? = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { record in
        if (Calendar.current.isDateInToday(record.startDate) && record.endDate == nil) {
          return true
        }
        
        if (record.endDate == nil) {
          return true
        }
        
        return false
    }
    .last
    
    return TodayViewModel(userInfo, workRecordOfToday: workRecordOfToday)
  }
}
