//
//  HistoryDateCheckView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDateCheckView: UIView {
  
  enum Text {
    static let TODAY = "Today".localized;
  }
  
  let currentYearMonthButton = HistoryButton().then {
    $0.setTitle(Formatter.yyyyMM.string(from: Date()), for: .normal)
  }
  
  let todayButton = HistoryButton().then {
    $0.setTitle(Text.TODAY, for: .normal)
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.addSubview(self.currentYearMonthButton)
    self.addSubview(self.todayButton)
    
    let ymLabel = UILabel().then {
      $0.text = self.currentYearMonthButton.titleLabel?.text
      $0.sizeToFit()
    }
    
    let tdLabel = UILabel().then {
      $0.text = self.todayButton.titleLabel?.text
      $0.sizeToFit()
    }
    
    self.todayButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-10)
      $0.size.equalTo(CGSize(width: (tdLabel.frame.size.width + 32), height: 40))
    }
    self.currentYearMonthButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalTo(self.todayButton.snp.leading).offset(-8)
      $0.size.equalTo(CGSize(width: (ymLabel.frame.size.width + 32), height: 40))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
