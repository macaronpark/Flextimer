//
//  TodayViewController_Notification.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension TodayViewController {
  
  func setupWorkRecordNotification() {
    let results = RealmService.shared.realm.objects(WorkRecord.self)
    
    self.workRecordNotificationToken = results.observe { [weak self] changes in
      guard let self = self else { return }
      
      switch changes {
      case .initial, .update:
        // setup ViewModel
        let userInfo = RealmService.shared.userInfo
        
        let record: WorkRecord? = RealmService.shared.realm
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
        
        guard let workRecordOfToday = record else {
          // 퇴근 처리
          self.isWorking.accept(false)
          return
        }
        // 출근 처리
        self.todayViewModel = TodayViewModel(userInfo, workRecordOfToday: workRecordOfToday)
        self.isWorking.accept(true)

      default:
        break
      }
    }
  }
  
  func setupUserInfoNotification() {
    let results = RealmService.shared.realm.objects(UserInfo.self)
    
    self.userInfoNotificationToken = results.observe { [weak self] changes in
      guard let self = self else { return }
      
      switch changes {
      case .update:
        self.todayView.optionView.rx.updateUI.onNext(self.todayViewModel)
        self.todayView.stackView.rx.viewModel.onNext((self.todayViewModel, self.isWorking.value))
        
      default:
        break
      }
    }
  }
}
