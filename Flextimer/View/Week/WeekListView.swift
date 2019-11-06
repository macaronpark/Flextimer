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
  
  @State private var date = Date()
  let logsForThisWeek = RealmService.shared.logForThisWeek()
  @State private var showingModal = false
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
            .onTapGesture {
                if self.logsForThisWeek.filter({ Calendar.current.isDate($0.date, inSameDayAs: date) }).count != 0 {
                    self.date = date
                    self.showingModal = true
                }
          }
          .sheet(isPresented: self.$showingModal) { WeekDetailView(date: self.date) }
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
  
  private func detail(_ date: Date) -> String {
    let records = self.logsForThisWeek.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    
    guard let record = records.last else {
        return (Calendar.current.isDateInToday(date)) ? self.userData.ingTimeInterval?.toString(.week) ?? "": ""
    }
    
    if (record.endDate != nil) {
        return self.getWorkingHour(record.date, end: record.endDate)
    } else {
        return self.userData.ingTimeInterval?.toString(.week) ?? ""
    }
  }
  
  private func getWorkingDates() -> [Date] {
    let dates = Date.datesOfThisWeek()
    var workDates = [Date]()
    for i in self.userData.workdays {
      workDates.append(dates[i])
    }
    return workDates
  }
  
  private func getWorkingHour(_ start: Date?, end: Date?) -> String {
    guard let start = start,
        let end = end else { return "" }
    
    let interval = end.timeIntervalSince(start).rounded()
    return interval.toString(.week)
  }
  
  private func getRemainTime() -> String {
    // 남은 근무 시간 구하기
    // 1. records의 end-start 인터벌 총 더하기
    var itvSum = self.logsForThisWeek
        .map{$0.endDate?.timeIntervalSince($0.date).rounded() ?? 0}
        .reduce(TimeInterval(), +)
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
