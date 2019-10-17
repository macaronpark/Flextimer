//
//  SettingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/04.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CreteriaView: View {
  
  @EnvironmentObject var userData: UserData
  
  var body: some View {
    HStack {
      HStack {
        Text("일 \(userData.workingHours)시간")
        Text("・")
        Text("주 \(userData.workdaysCount)일")
        Text("・")
        Text("\(userData.workdaysCount * userData.workingHours)시간 기준")
      }
      .font(.footnote)
      .foregroundColor(Color.gray)
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
  }
}

#if DEBUG
struct CreteriaView_Previews: PreviewProvider {
  static var previews: some View {
    CreteriaView().environmentObject(UserData())
  }
}
#endif
