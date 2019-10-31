//
//  WeekDetailView.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/28.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct WeekDetailView: View {
  
  var date: Date?
  @State private var today = Date()
    
    
  var body: some View {
    NavigationView {
      Form {
        Section {
            DatePicker(selection: $today, displayedComponents: .hourAndMinute) {
                Text("출근 시간")
            }
        }
        
        Section {
          DatePicker(selection: $today, displayedComponents: .hourAndMinute) {
              Text("퇴근 시간")
          }
        }
      }
      .navigationBarTitle(Formatter.dayName.string(from: date ?? Date()))
      .onAppear { print(self.date) }
    }
  }
}

//struct WeekDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationView {
//      WeekDetailView(record: WorkRecord())
//    }
//  }
//}
