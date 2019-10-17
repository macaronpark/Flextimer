//
//  RootView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import RealmSwift

struct RootView: View {
  
  @EnvironmentObject var userData: UserData
  
  var body: some View {
    NavigationView {
      VStack {
        // 근무 일, 시간을 표출하는 View
        CreteriaView()
        // 출, 퇴근 버튼 View
        ButtonView().padding(.top, 24)
        Spacer()
        // 근무 중일 경우 아래 View를 표출
        if self.userData.isWorking {
          TimerView()
          Spacer()
          RowListView()
        }
      }
      .navigationBarTitle(Text("오늘의 근태"), displayMode: .large)
      .navigationBarItems(trailing: link(destination: WeekView()))
    }
  }
  
  private func link<Destination: View>(destination: Destination) -> some View {
    NavigationLink(destination: destination) { Text("기록") }
  }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
#endif
