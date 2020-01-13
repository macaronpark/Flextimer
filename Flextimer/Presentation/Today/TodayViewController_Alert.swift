//
//  TodayViewController_Alert.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/13.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension TodayViewController {
  func showStartAlert() {
    // 오늘 자 기록을 기준으로 분기
    let workRecordInToday: WorkRecord? = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { Calendar.current.isDateInToday($0.startDate) }
      .last
    
    if let workRecordInToday = workRecordInToday {
      // - 기록이 있다면: 경고 얼럴트
      let alert = UIAlertController(
        title: "오늘 이미 출근한 기록이 있네요🧐",
        message: "기록을 삭제하고 다시 출근할까요?",
        preferredStyle: .alert
      )
      
      alert.view.tintColor = Color.immutableOrange
      
      let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
      let ok = UIAlertAction(title: "확인", style: .default) { _ in
        // 이전 기록 삭제
        RealmService.shared.delete(workRecordInToday)
        
        // 새 기록 생성
        let now = Date()
        let newWorkRecord = WorkRecord(now)
        RealmService.shared.create(newWorkRecord)
        DispatchQueue.main.async {
          NotificationCenter.default.post(name: RNotiKey.didUpdateWorkRecord, object: nil)
        }
      }
      
      alert.addAction(cancel)
      alert.addAction(ok)
      
      self.navigationController?.present(alert, animated: true, completion: nil)
    } else {
      // - 기록이 없다면: 새로운 WorkRecord를 생성
      let now = Date()
      let newWorkRecord = WorkRecord(now)
      RealmService.shared.create(newWorkRecord)
      DispatchQueue.main.async {
        NotificationCenter.default.post(name: RNotiKey.didUpdateWorkRecord, object: nil)
      }
    }
  }
  
  func showEndAlert() {
    let alert = UIAlertController(title: nil, message: "퇴근...할까요?💖", preferredStyle: .alert)
    alert.view.tintColor = Color.immutableOrange
    let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    let ok = UIAlertAction(title: "확인", style: .default) { _ in
      let record =  RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { $0.endDate == nil }
        .last
      
      if let record = record {
        RealmService.shared.update(record, with: ["endDate": Date()])
        
        DispatchQueue.main.async {
          NotificationCenter.default.post(name: RNotiKey.didUpdateWorkRecord, object: nil)
        }
      }
    }
    alert.addAction(cancel)
    alert.addAction(ok)
    self.navigationController?.present(alert, animated: true, completion: nil)
  }
}
