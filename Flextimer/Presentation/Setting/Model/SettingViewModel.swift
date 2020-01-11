//
//  SettingSectionModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

struct SettingViewModel {
  
  var sections: [[SettingCellModel]]
  
  init() {
    let workhourADay = [
      SettingCellModel(nil, text: "9시간 30분", component: .indicator)
    ]
    
    let workdayPerWeek = [
      SettingCellModel(nil, text: nil, component: .none)
    ]
    
    let etc = [
      SettingCellModel("버전", text: InfoUtil.versionDescription, component: .none),
      SettingCellModel("개발자", text: "github.com/macaronpark", component: .indicator),
      SettingCellModel("오픈소스", text: nil, component: .indicator)
    ]
    
    self.sections = [workhourADay, workdayPerWeek, etc]
  }
}
