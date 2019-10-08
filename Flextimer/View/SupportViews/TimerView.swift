//
//  TimerView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/08.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct TimerView: View {
  
  @EnvironmentObject var userData: UserData
  @State private var currentTime: String = ""
  @State private var timeToCallOut: String = ""
  
  let timer = CurrentTimer()

  var body: some View {
    VStack {
      Text("\(self.currentTime)")
        .font(.largeTitle)
        .padding(.bottom, 8)
      
      HStack {
        Text(" 퇴근까지")
        Text("\(self.timeToCallOut)")
      }
      .font(.body)
      .foregroundColor(Color.gray.opacity(0.4))
    }
    .onReceive(timer.currentTimePublisher) { newCurrentTime in
      if let startDate = self.userData.startDate {
        // 총 근무 시간 업데이트
        let interval = newCurrentTime.timeIntervalSince(startDate)
        self.currentTime = interval.toString(.total)
        // 남은 근무 시간(픽스 근무 시간 - 총 근무 시간) 업데이트
        let workingHoursInterval = TimeInterval(self.userData.workingHours * 60 * 60)
        let remainInterval = workingHoursInterval - interval
        self.timeToCallOut = remainInterval.toString(.remain)
      }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
  }
}
