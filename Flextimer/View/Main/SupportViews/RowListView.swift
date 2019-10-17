//
//  RowListView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct RowListView: View {
  
  @EnvironmentObject var userData: UserData
  
  var body: some View {
    VStack {
      MainRowView(row: Row(id: 1, title: "출근", detail: self.userData.startTime, color: .gray))
      MainRowView(row: Row(id: 2, title: "예상퇴근", detail: self.userData.estimatedCallOutTime))
      MainRowView(row: Row(id: 3, title: "퇴근까지", detail: self.userData.remainTime, color: AppColor.orange))
      Text(" ") // 마진 확보
    }
  }
}

#if DEBUG
struct RowListView_Previews: PreviewProvider {
  static var previews: some View {
    RowListView().environmentObject(UserData())
  }
}
#endif
