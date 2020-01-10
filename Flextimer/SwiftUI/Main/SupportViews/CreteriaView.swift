////
////  SettingView.swift
////  Flextimer
////
////  Created by Suzy Mararon Park on 2019/10/04.
////  Copyright © 2019 Suzy Mararon Park. All rights reserved.
////
//
//import SwiftUI
//import RealmSwift
//
///// 근무 일, 시간을 표출하는 View
//struct CreteriaView: View {
//  
//  @EnvironmentObject var userData: UserData
//  
//  var body: some View {
//    HStack {
//      HStack {
//        Text("일 \(userData.workingHours.value + 1)시간")
//        Text("・")
//        Text("주 \(userData.workdays.count)일")
//        Text("・")
//        Text("\(userData.workdays.count * (userData.workingHours.value + 1))시간 기준")
//      }
//      .font(.footnote)
//      .foregroundColor(Color.gray)
//      
//      Spacer()
//      
//      NavigationLink(destination: SettingView()) {
//        Image("setting")
//          .renderingMode(.original)
//          .resizable()
//          .frame(width: 20, height: 20)
//      }
//    }
//    .padding(.horizontal, 20)
//    .padding(.vertical, 8)
//  }
//}
//
//#if DEBUG
//struct CreteriaView_Previews: PreviewProvider {
//  static var previews: some View {
//    CreteriaView().environmentObject(UserData())
//  }
//}
//#endif
