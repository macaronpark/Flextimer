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
  
  init(_ models: [HistoryCellModel]) {
    var sections = [HistroySectionModel]()
    var tempCell = models
    
    // 1: 셀모델을 주단위로 쪼갠다
    let weekRange = Calendar.current.range(of: .weekOfMonth, in: .month, for: Date())!
    
    let _ = weekRange.map { weekIdx in
      // 첫 째 주의 weekday 수집 (디폴트로 토요일까지 수집 됨)
      var weekdays = tempCell.filter {
        Calendar.current.date($0.date, matchesComponents: DateComponents(weekOfMonth: weekIdx))
      }
      
      // 마지막 주의 경우 남은 날짜를
      if (weekIdx == weekRange.count) {
        let section = HistroySectionModel(weekdays)
        sections.append(section)
        return
      }
      
      // 일요일 추가 수집
      weekdays.append(tempCell[weekdays.count])
      
      // 주 모델 반환
      let section = HistroySectionModel(weekdays)
      sections.append(section)
      
      // 반환된 날짜 지우기 (일요일도 포함되서 삭제되므로 둘째 주부터는 월요일부터 계산된다)
      tempCell.removeSubrange(0..<weekdays.count)
    }
    
    // 2: 주단위를 섹션모델로 만든다
    // 3: 만들어진 섹션모델들로 뷰모델을 만든다
    
    // 섹션모델이 완전한 주(월요일부터 일요일을 모두 포함하는 주)가 아니면 완전한 주로 반환
    self.sections = sections.map { model -> HistroySectionModel in
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
