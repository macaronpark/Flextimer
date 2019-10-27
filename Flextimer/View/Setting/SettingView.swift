//
//  SettingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift

struct SettingView: View {
  
  @EnvironmentObject var userData: UserData
  let days = ["월", "화", "수", "목", "금", "토", "일"]

  var body: some View {
    Form {
      Section(header: Text("주 근무 요일")) {
        HStack {
          ForEach(0 ..< days.count) { idx in
            Spacer()
            Text(self.days[idx])
              .padding(8)
              .background(self.userData.workdays.contains(idx) ? AppColor.orange: Color.gray)
              .foregroundColor(.white)
              .cornerRadius(6)
              .onTapGesture {

                if self.userData.workdays.contains(idx) {
                  if let index = self.userData.workdays.firstIndex(of: idx) {
                    self.userData.workdays.remove(at: index)
                  }
                } else {
                  self.userData.workdays.append(idx)
                }

                let sorted = self.userData.workdays.sorted { $0 < $1 }
                self.userData.workdays = sorted
                RealmService.shared.update(
                  RealmService.shared.userInfo(),
                  with: ["workdays": sorted]
                )
            }
            Spacer()
          }
        }
      }
    }.navigationBarTitle(Text("설정"))
  }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView().environmentObject(UserData())
  }
}
#endif
