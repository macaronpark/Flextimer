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
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupAppearance()
    
    let todayViewModel = self.todayViewModel()
    let todayVC = TodayViewController(todayViewModel)
    let todayNVC = UINavigationController(rootViewController: todayVC)
    todayNVC.tabBarItem = UITabBarItem(title: "오늘의 근태", image: UIImage(named: "tab_today"), tag: 0)
    
    let historyCellModel = self.historyCellModel()
    let historyVC = HistoryViewController(historyCellModel)
    let historyNVC = UINavigationController(rootViewController: historyVC)
    historyNVC.tabBarItem = UITabBarItem(title: "기록", image: UIImage(named: "tab_history"), tag: 0)
    
    let tabBarList = [todayNVC, historyNVC]
    viewControllers = tabBarList
  }
  
  
  // MARK: - Custom Methods
  
  fileprivate func setupAppearance() {
    let appearance = UITabBarAppearance()
    appearance.stackedLayoutAppearance.normal.iconColor = Color.immutableLightGray
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.immutableLightGray]
    appearance.stackedLayoutAppearance.selected.iconColor = Color.immutableOrange
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.immutableOrange]
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
  
  fileprivate func historyCellModel() -> [HistoryCellModel] {
    let comp = Calendar.current.dateComponents([.year, .month], from: Date())
    let allDates: [Date] = self.allDatesIn(month: comp.month ?? 0, year: comp.year ?? 0)
    return allDates.map { HistoryCellModel($0) }
  }
  
  fileprivate func allDatesIn(month: Int, year: Int) -> [Date] {
    let startDateComponents = DateComponents(year: year, month: month, day: 1)
    let endDateComponents = DateComponents(year: year, month: month + 1, day: 0)
    
    guard let startDate = Calendar.current.date(from: startDateComponents),
      let endDate = Calendar.current.date(from: endDateComponents),
      startDate < endDate else { return [Date]() }
    
    var tempDate = startDate
    var dates = [tempDate]
    
    while tempDate < endDate {
      tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
      dates.append(tempDate)
    }
    
    return dates
  }
}
