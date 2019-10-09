//
//  RowView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine

struct RowView: View {
  
  @EnvironmentObject var userData: UserData
  
  // title, sub, color
  
  var body: some View {
    
    VStack {
      
      HStack {
        Text("title")
        Spacer()
        Text("value")
        
      }
      .font(.body)
      .padding(.vertical, 8)
      .padding(.horizontal, 20)
      
      HStack {
        Spacer()
        AppColor.placeholderGray.frame(width: UIScreen.main.bounds.width - 48, height: 1)
      }
    }
  }
}

struct RowView_Previews: PreviewProvider {
  static var previews: some View {
    RowView().environmentObject(UserData())
  }
}
