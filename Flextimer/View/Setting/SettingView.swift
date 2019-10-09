//
//  SettingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine
import UIKit
import RealmSwift

struct SettingView: View {
  
  @ObservedObject var creteria = Creteria()
  @EnvironmentObject var userData: UserData
  
  var body: some View {
      WorkdayPickerView().navigationBarTitle(Text("설정"))
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView().environmentObject(UserData())
  }
}
