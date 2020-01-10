//
//  SettingSectionModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

struct SettingViewModel {
  
  var sections: [SettingSectionModel]
  
  init() {
    // 일일 근무 시간
    var workhoursADayRows = [SettingCellModel]()
    workhoursADayRows = [
      SettingCellModel(nil, text: "9시간 30분", component: .indicator, action: { nvc in
        // show picker
      })
    ]
    let workhoursADaySection = SettingSectionModel(title: "일일 근무 시간", rows: workhoursADayRows)
    
    // 주간 근무 요일
    var workdaysPerWeekRows = [SettingCellModel]()
    workdaysPerWeekRows = [
      SettingCellModel(nil, text: nil, component: .none, action: { nvc in
        // show button view
      })
    ]
    let workdaysPerWeekSection = SettingSectionModel(title: "주간 근무 요일", rows: workdaysPerWeekRows)
    
    // 기타
    var etcRows = [SettingCellModel]()
    etcRows = [
      SettingCellModel("버전", text: InfoUtil.versionDescription.text, component: .none, action: { nvc in
        if InfoUtil.versionDescription.isAvailable {
          if let url = URL(string: "https://itunes.apple.com/app/id1484457501") {
            UIApplication.shared.open(url)
          }
        }
      }),
      SettingCellModel("개발자", text: "github.com/macaronpark", component: .indicator, action: { nvc in
        if let url = URL(string: "https://github.com/macaronpark") {
          UIApplication.shared.open(url)
        }
      }),
      SettingCellModel("오픈소스", text: nil, component: .indicator, action: { nvc in
        if let url = URL(string: "https://www.notion.so/Opensources-5f23792b38334a17b6795a00dc20de7b") {
          UIApplication.shared.open(url)
        }
      }),
    ]
    let etcSection = SettingSectionModel(title: "기타", rows: etcRows)
    
    self.sections = [workhoursADaySection, workdaysPerWeekSection, etcSection]
  }
}
