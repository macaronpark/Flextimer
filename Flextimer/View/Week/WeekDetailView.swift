//
//  WeekDetailView.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/28.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct WeekDetailView: View {
  
  @ObservedObject var viewModel: WeekDetailViewModel
  @Binding var isPresented: Bool
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          DatePicker(selection: $viewModel.startDate, displayedComponents: .hourAndMinute) {
            Text("출근 시간")
          }
        }
        
        Section {
          DatePicker(selection: $viewModel.endDate, displayedComponents: .hourAndMinute) {
            Text("퇴근 시간")
          }
        }
      }
      .navigationBarTitle(Formatter.dayName.string(from: self.viewModel.startDate))
      .navigationBarItems(trailing: Text("저장").onTapGesture {
        RealmService.shared.update(self.viewModel.realmObject, with: ["date": self.viewModel.startDate, "endDate": self.viewModel.endDate])
        self.isPresented = false
      })
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
