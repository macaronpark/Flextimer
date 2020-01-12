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
  }
  
  @objc func didUpdateOptionsNotification(_ notification: NSNotification) {
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
  }
  
  @objc func didUpdateWorkhousNotification(_ notification: NSNotification) {
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
  }
}
