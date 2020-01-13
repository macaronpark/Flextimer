////
////  WeekDetailView.swift
////  Flextimer
////
////  Created by Suzy Park on 2019/10/28.
////  Copyright © 2019 Suzy Mararon Park. All rights reserved.
////
//
//import SwiftUI
//
//struct WeekDetailView: View {
//  
//  @ObservedObject var viewModel: WeekDetailViewModel
//  @Binding var isPresented: Bool
//  
//  var isStartEdited = false
//  var isEndEdited = false
//  
//  var body: some View {
//    NavigationView {
//      Form {
//        Section() {
//          DatePicker(selection: $viewModel.startDate, displayedComponents: .hourAndMinute) {
//            Text("출근 시간")
//          }
//        }
//        
//        Section(footer: Text("출퇴근 기록을 깜박하셨나요? 시간을 눌러서 수정해주세요.")) {
//          DatePicker(selection: $viewModel.endDate, displayedComponents: .hourAndMinute) {
//            Text("퇴근 시간")
//          }
//        }
//      }
//      .navigationBarTitle(("\(Formatter.dayName.string(from: self.viewModel.startDate))"), displayMode: .inline)
//      .navigationBarItems(trailing: Text("저장").onTapGesture {
//        
//        if (self.viewModel.isStartEdited && self.viewModel.isEndEdited) {
//          RealmService.shared.update(self.viewModel.realmObject, with: ["date": self.viewModel.startDate, "endDate": self.viewModel.endDate])
//        } else if (self.viewModel.isStartEdited == true && self.viewModel.isEndEdited == false) {
//          RealmService.shared.update(self.viewModel.realmObject, with: ["date": self.viewModel.startDate])
//        } else if (self.viewModel.isStartEdited == false && self.viewModel.isEndEdited == true) {
//          RealmService.shared.update(self.viewModel.realmObject, with: ["endDate": self.viewModel.endDate])
//        }
//        
//        self.isPresented = false
//      })
//    }
//  }
//}
//
////struct WeekDetailView_Previews: PreviewProvider {
////  static var previews: some View {
////    NavigationView {
////      WeekDetailView(record: WorkRecord())
////    }
////  }
////}
