//
//  Today_Action.swift
//  Widget
//
//  Created by Suzy Mararon Park on 2019/10/18.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit

extension TodayViewController {
  
//  @objc func timerHandler() {
//    let current = Date()
//    let calendar = Calendar.current
//    let creteriaComp = calendar.component(.minute, from: self.timeCreteria)
//    let currentComp = calendar.component(.minute, from: current)
//    
//    if creteriaComp != currentComp {
//      self.timeCreteria = current
//      self.widgetPerformUpdate { result in }
//    }
//  }
//
//  @objc func tapStartButton(_ sender: UIButton) {
//    if let _ = RealmService.shared.getTodayRecord() {
//      self.alertLabel.isHidden = false
//      self.alertLabel.textColor = .red
//      self.alertLabel.text = "오늘 이미 근무한 기록이 있네요? 앱에서 '출근'버튼을 눌러서 확인해주세요"
//    } else {
//      // 기록이 없다면: 새로운 WorkRecord를 생성
//      let now = Date()
//      let newWorkRecord = WorkRecord(now)
//      RealmService.shared.create(newWorkRecord)
//      self.widgetPerformUpdate { result in }
//    }
//  }
//  
//  @objc func tapEndButton(_ sender: UIButton) {
//    let result = RealmService.shared.realm.objects(WorkRecord.self).filter { $0.endDate == nil }
//    if let record = result.last {
//      let endDate = ["endDate": Date()]
//      RealmService.shared.update(record, with: endDate)
//      self.widgetPerformUpdate { result in }
//    }
//  }
}
