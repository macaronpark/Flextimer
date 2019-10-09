//
//  WorkdayPickerView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct WorkdayPickerView: View {
  
  @ObservedObject var creteria = Creteria()
  
  var body: some View {
    Form {
      Picker(selection: $creteria.workDayCount, label: Text("근무 일 수")) {
        ForEach(0 ..< creteria.workDayCount.count) {
          Text(self.creteria.workDayCount[$0]).tag($0)
        }
      }
    }
  }
}

struct WorkdayPickerView_Previews: PreviewProvider {
  static var previews: some View {
    WorkdayPickerView()
  }
}
