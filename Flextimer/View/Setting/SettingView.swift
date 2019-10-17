//
//  SettingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift

struct SettingView: View {
  
  @EnvironmentObject var userData: UserData
  
  var strengths = ["Mild", "Medium", "Mature"]
  @State private var selectedStrength = 0
  
  var body: some View {
//    Text("")
    Form {
      Section {
        Picker(selection: $selectedStrength, label: Text("Strength")) {
          Text("")
          Text("")
          Text("")
//          ForEach(0 ..< strengths.count) {
//            Text(self.strengths[$0]).tag($0)
//          }
        }
      }
    }.navigationBarTitle(Text("설정"))
  }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView().environmentObject(UserData())
  }
}
#endif
