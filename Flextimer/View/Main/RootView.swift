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
  @State private var selection: Int? = nil
  
  init() {
    UINavigationBar.appearance().tintColor = .orange
  }
  
  var body: some View {
    NavigationView {
      VStack {
        CreteriaView()
        ButtonView().padding(.top, 24)
        Spacer()
        if self.userData.isWorking {
          TimerView()
          Spacer()
          RowListView()
        }
      }
      .navigationBarTitle(Text("오늘의 근태"), displayMode: .large)
      .navigationBarItems(trailing: link(destination: WeekView()))
    }
    .onAppear {
      let r = RealmService.shared.realm.objects(WorkRecord.self)
      DebugPrint.debug("\(r)")
    }
  }
  
  private func link<Destination: View>(destination: Destination) -> some View {
    NavigationLink(destination: destination) {
      Text("기록")
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
