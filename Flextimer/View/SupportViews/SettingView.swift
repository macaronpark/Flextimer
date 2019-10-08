//
//  SettingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/04.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import RealmSwift

struct SettingView: View {
  
  @EnvironmentObject var userData: UserData
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 2) {
        Group {
          HStack {
            Text("주 \(userData.workdaysCount)일")
            Text("\(userData.workdaysCount * userData.workingHours)시간").fontWeight(.bold)
          }
          
          HStack {
            Text("일")
            Text("\(userData.workingHours)시간").fontWeight(.bold)
            Text("기준")
          }
        }
        .font(.footnote)
        .foregroundColor(Color.gray.opacity(0.4))
      }
      Spacer()
      
      Button(action: {
        
      }) {
        Image("setting")
          .renderingMode(.init(Image.TemplateRenderingMode.original))
          .resizable()
          .frame(width: 20, height: 20)
      }
    }
    .padding(.horizontal, 40)
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}
