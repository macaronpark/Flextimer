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

struct ContentView: View {
  // option + cmd + p: make the preview window reload
  @EnvironmentObject var userData: UserData
  
  var body: some View {
    NavigationView {
      
      VStack {
        SettingView()
        ButtonView().padding(.top, 24)
        
        if self.userData.isWorking {
          Spacer()
          TimerView().padding(.top, 24)
          Spacer()
          
          RowView()
          RowView()
          RowView()
        }
        
        Spacer()
      }
      .navigationBarTitle(Text("오늘의 근태"), displayMode: .large)
      .navigationBarItems(trailing:
        Button(action: {
          print("Help tapped!")
        }) {
          Image("setting")
          .renderingMode(.init(Image.TemplateRenderingMode.original))
          .resizable()
          .frame(width: 24, height: 24)
      })
      
    }.onAppear {
      
      let r = RealmService.shared.realm.objects(WorkRecord.self)
      DebugPrint.debug("\(r)")
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(UserData())
  }
}
