//
//  TodayButtonsView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class TodayButtonsView: UIView {
  
  let startButton = TodayButton("출근")
  let endButton = TodayButton("퇴근")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.startButton)
    self.addSubview(self.endButton)
    
    self.startButton.snp.makeConstraints {
      $0.leading.top.bottom.equalToSuperview()
      $0.height.equalTo(48)
      $0.width.equalTo((ScreenSize.width - 56) / 2)
    }
    self.endButton.snp.makeConstraints {
      $0.top.equalTo(self.startButton)
      $0.leading.equalTo(self.startButton.snp.trailing).offset(16)
      $0.trailing.equalToSuperview()
      $0.height.equalTo(48)
      $0.width.equalTo((ScreenSize.width - 56) / 2)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  func updateUI(_ isWorking: Bool) {
//    self.startButton.isEnabled = (isWorking) ? false: true
//    self.endButton.isEnabled = (isWorking) ? true: false
//  }
}

extension Reactive where Base: TodayButtonsView {
  var updateUI: Binder<Bool> {
    return Binder(self.base) { base, isWorking in
      base.startButton.isEnabled = (isWorking) ? false: true
      base.endButton.isEnabled = (isWorking) ? true: false
    }
  }
}
