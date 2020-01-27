//
//  HistoryDateCheckView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDateCheckView: UIView {
  
  let currentYearMonthButton = HistoryButton().then {
    $0.setTitle(Formatter.yyyyMM.string(from: Date()), for: .normal)
  }
  
  let todayButton = HistoryButton().then {
    $0.setTitle("오늘", for: .normal)
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.addSubview(self.currentYearMonthButton)
    self.addSubview(self.todayButton)
    
    self.todayButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-10)
      $0.size.equalTo(CGSize(width: 60, height: 40))
    }
    self.currentYearMonthButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalTo(self.todayButton.snp.leading).offset(-8)
      $0.size.equalTo(CGSize(width: 120, height: 40))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
