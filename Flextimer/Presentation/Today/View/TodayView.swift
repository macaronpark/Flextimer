//
//  TodayView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class TodayView: UIView {
  
  let optionView = TodayOptionView()
  let buttonsView = TodayButtonsView()
  let timerView = TodayTimerView()
  let stackView = TodayListStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(optionView)
    self.addSubview(buttonsView)
    self.addSubview(timerView)
    self.addSubview(stackView)
    
    self.optionView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
    }
    self.buttonsView.snp.makeConstraints {
      $0.top.equalTo(self.optionView.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    self.timerView.snp.makeConstraints {
      $0.top.equalTo(self.buttonsView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.stackView.snp.top)
    }
    self.stackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-24)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
