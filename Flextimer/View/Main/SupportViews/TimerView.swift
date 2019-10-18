//
//  TimerView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/08.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct TimerView: View {
  
  let timer = CurrentTimer()
  @EnvironmentObject var userData: UserData
  /// Date()와 출근시간의 기록 차
  @State private var currentTime: String = ""
  /// "지금은 근무 중" text를 표출하는 state. 타이머가 뷰보다 살짝 늦게 뜨므로 타이머가 set되는 시점에 맞춰 표출하기 위해 state로 빼 놓음
  @State private var workingDescription: String = ""
  
  var body: some View {
    VStack {
      Text("\(self.workingDescription)")
        .font(.body)
        .foregroundColor(Color.gray)
      
      Text("\(self.currentTime)")
        .font(Font.system(size: 60, weight: .light, design: .monospaced))
        .foregroundColor(AppColor.orange)
    }
    .onReceive(timer.currentTimePublisher) { newCurrentTime in
      self.updateStates(newCurrentTime)
    }
  }
  
  // todo: refactoring 🤢🤮
  func updateStates(_ output: Timer.TimerPublisher.Output) {
    if let startDate = self.userData.startDate {
      // 총 근무 시간 업데이트
      let trimmedStartDate = startDate.trimSeconds() ?? startDate
      let interval = output.timeIntervalSince(trimmedStartDate).rounded()
      self.userData.ingTimeInterval = interval
      self.currentTime = interval.toString(.total)
      // 남은 근무 시간(픽스 근무 시간 - 총 근무 시간) 업데이트
      let workingHoursInterval = self.userData.workingHours.toRoundedTimeInterval()
      let remainInterval = workingHoursInterval - interval
      self.userData.remainTime = remainInterval.toString(.remain) + " 남았어요"
      self.workingDescription = "지금은 근무 중"
    }
  }
}

#if DEBUG
struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView().environmentObject(UserData())
  }
}
#endif
