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
  
  init(_ model: UserInfo) {
    let hourOnly = "\(model.hourOfWorkhoursADay)시간"
    let hourAndMinute = "\(model.hourOfWorkhoursADay)시간 \(model.minuteOfWorkhoursADay)분"
    let workhourADayString = (model.minuteOfWorkhoursADay == 0) ? hourOnly: hourAndMinute
    
    let workhourADay = [SettingCellModel(nil, text: workhourADayString, component: .indicator)]
    
    let workdayPerWeek = [SettingCellModel(nil, text: nil, component: .none)]
    
    let etc = [
      SettingCellModel("버전", text: InfoUtil.versionDescription, component: .indicator),
      SettingCellModel("개발자", text: "github.com/macaronpark", component: .indicator),
      SettingCellModel("오픈소스", text: nil, component: .indicator),
      SettingCellModel("튜토리얼 다시보기", text: nil, component: .indicator)
    ]
    
    self.sections = [workhourADay, workdayPerWeek, etc]
  }
}
