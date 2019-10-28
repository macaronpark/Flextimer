//
//  WeekListView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/10.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

// todo: refactoring 🤢🤮
struct WeekListView: View {
  
  private var records = RealmService.shared.logForThisWeek()
  @State private var totalWorkingTime: TimeInterval = 0
  @EnvironmentObject var userData: UserData
  
  var body: some View {
    VStack {
      VStack {
        
        ForEach(self.getWorkingDates(), id: \.self) { date in
            MainRowView(row: Row(
                title: Formatter.dayName.string(from: date),
                detail: self.detail(date),
                color: Calendar.current.isDateInToday(date) ? nil: .gray
            ))
        }

        // 남은 근무시간
        MainRowView(row: Row(
          title: "이 주의 남은 근무 시간",
          detail: getRemainTime(),
          color: AppColor.orange)
        ).padding(.top, 24)
      }.padding(.top, 40)
      Spacer()
    }
  }
    
    func detail(_ date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return self.userData.ingTimeInterval?.toString(.week) ?? ""
        } else {
            let record = self.records.filter({ Calendar.current.isDate($0.date, inSameDayAs: date) })
            if let recordd = record.last {
                return self.getWorkingHour(recordd.date, end: recordd.endDate ?? Date())
            } else {
                return ""
            }
        }
    }
    
    func getWorkingDates() -> [Date] {
        let dates = Date.datesOfThisWeek()
        var workDates = [Date]()
        for i in self.userData.workdays {
            workDates.append(dates[i])
        }
        return workDates
    }

  private func getWorkingHour(_ start: Date, end: Date) -> String {
    let interval = end.timeIntervalSince(start).rounded()
    return interval.toString(.week)
  }
  
  private func getRemainTime() -> String {
    // 남은 근무 시간 구하기
    // 1. records의 end-start 인터벌 총 더하기
    var itvSum = TimeInterval()
    self.records.forEach { itvSum += $0.endDate?.timeIntervalSince($0.date).rounded() ?? TimeInterval() }
    // 1-1.현재 근무 중이라면 오늘 근무한 시간 인터벌을 총 인터벌에 더해준다
    if let todayIngTimeInterval = self.userData.ingTimeInterval {
      itvSum += todayIngTimeInterval
    }
    // 2. userData의 총근무시간을 타임인터벌로 만들어서
    let weekInterval = (self.userData.workdays.count * self.userData.workingHours).toRoundedTimeInterval()
    // 3. 총타임인터블 - 1 -> string
    return (weekInterval - itvSum).toString(.remain)
  }
}

#if DEBUG
struct WeekListView_Previews: PreviewProvider {
  static var previews: some View {
    WeekListView().environmentObject(UserData())
  }
}
#endif
