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
  
  var records = RealmService.shared.realm
    .objects(WorkRecord.self)
    .filter { $0.date >= Date().getMondayThisWeek() && $0.endDate != nil }
    .map { WorkRecord($0.date, endDate: $0.endDate) }
  
  @State private var totalWorkingTime: TimeInterval = 0
  @EnvironmentObject var userData: UserData
    
  var body: some View {
    VStack {
      VStack {
        
        ForEach(0..<self.records.count) { index in
          
          MainRowView(row: Row(
            id: 0,
            title: "\(Formatter.dayName.string(from: self.records[index].date))",
            detail: "\(self.getWorkingHour(self.records[index].date, end: self.records[index].endDate ?? Date()))", color: .gray))
          
        }
        
        MainRowView(row: Row(
          id: 5,
          title: "남은 근무 시간",
          detail: getRemainTime(),
          color: AppColor.orange)
        )
          .padding(.top, 24)
        
      }.padding(.top, 40)
      Spacer()
    }
  }
  
  private func getWorkingHour(_ start: Date, end: Date) -> String {
    let interval = end.timeIntervalSince(start)
    return interval.toString(.week)
  }
  
  private func getRemainTime() -> String{
    // 남은 근무 시간 구하기
    // 1. records의 end-start 인터벌 총 더하기
    var intervalSum = TimeInterval()
    for i in records {
      intervalSum += i.endDate?.timeIntervalSince(i.date) ?? TimeInterval()
    }
    // 2. userData의 총근무시간을 타임인터벌로 만들어서
    let weekInterval = TimeInterval((self.userData.workdaysCount * self.userData.workingHours) * 60 * 60)
    // 3. 총타임인터블 - 1 -> string
    return (weekInterval - intervalSum).toString(.week)
  }
}

#if DEBUG
struct WeekListView_Previews: PreviewProvider {
  static var previews: some View {
    WeekListView().environmentObject(UserData())
  }
}
#endif
