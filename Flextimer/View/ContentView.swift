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
          .padding(.top, 40)
        ButtonView()
          .padding(.top, 8)
        
        if self.userData.isWorking {
          TimeView()
            .padding(.top, 40)
          
          Spacer()
          
          TimerView()
          
          Spacer()
        }
        
        Spacer()
      }
      .navigationBarTitle(Text("오늘의 근태"), displayMode: .large)
      
    }.onAppear {
      
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(UserData())
  }
}
