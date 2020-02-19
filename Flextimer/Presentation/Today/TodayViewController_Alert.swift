//
//  TodayViewController_Alert.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/13.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension TodayViewController {
  
  func didTapStartButton() {
    // 오늘 자 기록을 기준으로 분기
    let workRecordInToday: WorkRecord? = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { Calendar.current.isDateInToday($0.startDate) }
      .last
    
    if let workRecordInToday = workRecordInToday {
      // - 기록이 있다면: 경고 얼럴트
      let alert = UIAlertController(
        title: Text.TVC_ALERT_TITLE_1,
        message: Text.TVC_ALERT_MESSAGE_1,
        preferredStyle: .alert
      )
      
      alert.view.tintColor = Color.immutableOrange
      
      let cancel = UIAlertAction(title: Text.CANCEL, style: .cancel, handler: nil)
      let ok = UIAlertAction(title: Text.OK, style: .default) { _ in
        // 이전 기록 삭제
        RealmService.shared.delete(workRecordInToday)
        self.todayViewModel.workRecordOfToday = nil
        self.isWorking.accept(false)
        
        // 새 기록 생성
        let now = Date()
        let newWorkRecord = WorkRecord(now)
        RealmService.shared.create(newWorkRecord)
        self.todayViewModel.workRecordOfToday = newWorkRecord
        self.isWorking.accept(true)
      }
      
      alert.addAction(cancel)
      alert.addAction(ok)
      
      self.navigationController?.present(alert, animated: true, completion: nil)
    } else {
      // - 기록이 없다면: 새로운 WorkRecord를 생성
      let now = Date()
      let newWorkRecord = WorkRecord(now)
      self.todayViewModel.workRecordOfToday = newWorkRecord
      self.isWorking.accept(true)
      RealmService.shared.create(newWorkRecord)
    }
  }
  
  func showEndAlert() {
    let alert = UIAlertController(title: nil, message: Text.TVC_ALERT_MESSAGE_2, preferredStyle: .alert)
    alert.view.tintColor = Color.immutableOrange
    let cancel = UIAlertAction(title: Text.CANCEL, style: .cancel, handler: nil)
    let ok = UIAlertAction(title: Text.OK, style: .default) { _ in
      let record =  RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { $0.endDate == nil }
        .last
      
      if let record = record {
        RealmService.shared.update(record, with: [WorkRecordEnum.endDate.str: Date()])
        self.todayViewModel.workRecordOfToday = nil
        self.isWorking.accept(false)
      }
    }
    
    alert.addAction(cancel)
    alert.addAction(ok)
    self.navigationController?.present(alert, animated: true, completion: nil)
  }
}
