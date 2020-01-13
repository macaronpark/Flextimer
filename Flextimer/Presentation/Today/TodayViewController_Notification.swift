//
//  TodayViewController_Notification.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension TodayViewController {
  
  func registerNotification() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateOptionsNotification(_:)),
      name: NSNotification.Name.didUpdateOptions,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateWorkhousNotification(_:)),
      name: RNotiKey.didUpdateHourOfWorkhoursADay,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateWorkhousNotification(_:)),
      name: RNotiKey.didUpdateMinuteOfWorkhoursADay,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateWorkRecordNotification(_:)),
      name: RNotiKey.didUpdateWorkRecord,
      object: nil
    )
  }
  
  @objc func didUpdateOptionsNotification(_ notification: NSNotification) {
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
  }
  
  @objc func didUpdateWorkhousNotification(_ notification: NSNotification) {
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
  }
  
  @objc func didUpdateWorkRecordNotification(_ notification: NSNotification) {
    
    // setup ViewModel
    let userInfo = RealmService.shared.userInfo
    
    let workRecordOfToday: WorkRecord? = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { record in
        if (Calendar.current.isDateInToday(record.startDate) && record.endDate == nil) {
          return true
        }
        
        if (record.endDate == nil) {
          return true
        }
        
        return false
    }
    .last
    
    self.todayViewModel = TodayViewModel(userInfo, workRecordOfToday: workRecordOfToday ?? nil)
    
    self.todayView.buttonsView.rx.viewModel.onNext(self.todayViewModel)
    
//    if self.todayViewModel.isWorking {
//      print("is Working")
//    } else {
//      print("is not Working")
//    }
  }
}
