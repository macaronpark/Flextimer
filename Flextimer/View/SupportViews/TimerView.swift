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
  @State private var preDescription: String = ""
  
  let timer = CurrentTimer()
  
  var body: some View {
    VStack {
      Text("\(self.currentTime)")
        .font(Font.system(size: 60, weight: .light, design: .monospaced))
        .foregroundColor(AppColor.orange)
      
      HStack {
        Text("\(self.preDescription)")
        Text("\(self.timeToCallOut)")
      }
      .font(.body)
      .foregroundColor(Color.gray)
    }
    .onReceive(timer.currentTimePublisher) { newCurrentTime in
      self.updateStates(newCurrentTime)
    }
  }
  
  func updateStates(_ output: Timer.TimerPublisher.Output) {
    if let startDate = self.userData.startDate {
      // 총 근무 시간 업데이트
      let interval = output.timeIntervalSince(startDate)
      self.currentTime = interval.toString(.total)
      // 남은 근무 시간(픽스 근무 시간 - 총 근무 시간) 업데이트
      let workingHoursInterval = TimeInterval(self.userData.workingHours * 60 * 60)
      let remainInterval = workingHoursInterval - interval
      self.timeToCallOut = remainInterval.toString(.remain)
      //
      self.preDescription = " 퇴근까지"
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView().environmentObject(UserData())
  }
}
