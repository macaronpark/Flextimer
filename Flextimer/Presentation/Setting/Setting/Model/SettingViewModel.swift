//
//  SettingSectionModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

struct SettingViewModel {
  
  enum Text {
    static let SVM_VERSION = "SVM_VERSION".localized
    static let SVM_DEVELOPER = "SVM_DEVELOPER".localized
    static let SVM_OPENSOURCE = "SVM_OPENSOURCE".localized
    static let SVM_TUTORIAL = "SVM_TUTORIAL".localized
  }
  
  var sections: [[SettingCellModel]]
  
  init(_ model: UserInfo) {
    let hourOnly = "%dhrs".localized(with: [model.hourOfWorkhoursADay])
    let hourAndMinute = "%dhrs %dmin".localized(with: [model.hourOfWorkhoursADay, model.minuteOfWorkhoursADay])
    let workhourADayString = (model.minuteOfWorkhoursADay == 0) ? hourOnly: hourAndMinute
    
    let workhourADay = [SettingCellModel(nil, text: workhourADayString, component: .indicator)]
    
    let workdayPerWeek = [SettingCellModel(nil, text: nil, component: .none)]
    
    let etc = [
      SettingCellModel("버전", text: InfoUtil.versionDescription, component: .indicator),
      SettingCellModel("개발자", text: "github.com/macaronpark", component: .indicator),
      SettingCellModel("오픈소스", text: nil, component: .indicator),
      SettingCellModel("튜토리얼", text: nil, component: .indicator)
    ]
    
    self.sections = [workhourADay, workdayPerWeek, etc]
  }
}
