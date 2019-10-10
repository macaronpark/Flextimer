//
//  ContentView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 04/10/2019.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift

struct MainView: View {
  // option + cmd + p: make the preview window reload
  @EnvironmentObject var userData: UserData
//  @State private var selection: Int? = nil
  
  var body: some View {
      VStack {
        CreteriaView().padding(.bottom, 24)
        ButtonView()
        Spacer()
        if self.userData.isWorking {
          TimerView()
          Spacer()
          RowListView()
        }
      }
      .navigationBarTitle(Text("오늘의 근태"), displayMode: .large)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().previewDevice("iphone 8")
  }
}
