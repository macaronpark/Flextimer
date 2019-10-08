//
//  WorkingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/08.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine

struct TimeView: View {
  
  @EnvironmentObject var userData: UserData
  
  var body: some View {
  
    VStack(alignment: .trailing) {

        HStack {
          Spacer()
          Text("출근")
          Text("\(userData.startTime)")
        }
        .padding(.bottom, 2)
        
        HStack {
          Spacer()
          Text("예상 퇴근")
          Text("\(userData.callOutTime)")
        }
        .foregroundColor(.gray)
      
    }
    .padding([.leading, .trailing], 40)
  }
}

struct WorkingView_Previews: PreviewProvider {
  static var previews: some View {
    TimeView()
  }
}
