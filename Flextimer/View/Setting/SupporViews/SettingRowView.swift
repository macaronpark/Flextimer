//
//  SettingRowView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct SettingRowView: View {
  
  var row: SettingRow
  
  var body: some View {
    HStack {
      Text(row.title)
      Spacer()
      Text(row.detail)
        .foregroundColor(.gray)
    }.padding(.horizontal)
  }
}

struct SettingRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SettingRowView(row: SettingRow(id: 0, title: "title", detail: "detail"))
      SettingRowView(row: SettingRow(id: 1, title: "title", detail: "detail"))
    }
    .previewLayout(.fixed(width: 300, height: 70))
  }
}
