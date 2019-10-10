//
//  RowView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine

struct MainRowView: View {
  
  @EnvironmentObject var userData: UserData
  
  var row: Row
  var body: some View {
    
    VStack {
      HStack {
        Text(row.title)
        Spacer()
        Text(row.detail)
      }
      .font(Font.system(size: 16))
      .foregroundColor(row.color)
      .padding(.vertical, 4)
      .padding(.horizontal, 20)
      
      HStack {
        Spacer()
        Color.gray
          .opacity(0.3)
          .frame(width: UIScreen.main.bounds.width - 20, height: 1)
      }
    }
  }
}

struct RowView_Previews: PreviewProvider {
  static var previews: some View {
    MainRowView(row: Row(id: 1, title: "test", detail: "test", color: .black))
      .environmentObject(UserData())
  }
}
