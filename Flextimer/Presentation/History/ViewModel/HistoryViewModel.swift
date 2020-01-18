//
//  HistoryViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/18.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class HistroySectionModel {
  var rows: [HistoryCellModel]
  
  init(_ models: [HistoryCellModel]) {
    self.rows = models
  }
}

class HistoryViewModel {
  
  var sections = [HistroySectionModel]()
  
  init(_ models: [HistroySectionModel]) {
    self.sections = models.map { model -> HistroySectionModel in
      if (model.rows.count == 7) {
        return model
      }
      return self.makeFullWeekdays(model)
    }
  }
  
  func makeFullWeekdays(_ weekdays: HistroySectionModel) -> HistroySectionModel {
    let firstDate = weekdays.rows[0].date
    let lastDate = weekdays.rows[weekdays.rows.count - 1].date
    let mondayInFirstDateWeek = firstDate.getThisWeekMonday()
    let sundayInFirstDateWeek = Calendar.current.date(byAdding: .day, value: 6, to: mondayInFirstDateWeek)
    
    if (firstDate == mondayInFirstDateWeek) {
      // 뒷 날짜 수집
      var tempDate = lastDate
      var arr = [Date]()
      
      while (tempDate != sundayInFirstDateWeek) {
        let increasedDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
        arr.append(increasedDate)
        if (increasedDate == sundayInFirstDateWeek) {
          break
        } else {
          tempDate = increasedDate
        }
      }
      
      arr
        .sorted(by: {$0 < $1})
        .map { HistoryCellModel($0) }
        .forEach { weekdays.rows.append($0) }
      
      return weekdays
    } else {
      // 앞 날짜 수집
      var tempDate = firstDate
      var arr = [Date]()
      
      while (tempDate != mondayInFirstDateWeek) {
        let decresedDate = Calendar.current.date(byAdding: .day, value: -1, to: tempDate)!
        arr.insert(decresedDate, at: 0)
        if (decresedDate == mondayInFirstDateWeek) {
          break
        } else {
          tempDate = decresedDate
        }
      }
      
      arr
        .sorted(by: {$0 > $1})
        .map { HistoryCellModel($0) }
        .forEach { weekdays.rows.insert($0, at: 0) }
      
      return weekdays
    }
  }
}
