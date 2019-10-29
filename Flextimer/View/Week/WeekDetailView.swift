//
//  WeekDetailView.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/28.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct WeekDetailView: View {
  
  var record: WorkRecord?
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("출근 시간")) {
          Text("d")
        }
        
        Section(header: Text("퇴근 시간")) {
          Text("d")
        }
      }
      .navigationBarTitle(Formatter.dayName.string(from: record?.date ?? Date()))
      .onAppear { print(self.record?.date) }
    }
  }
}

struct WeekDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      WeekDetailView(record: WorkRecord())
    }
  }
}
