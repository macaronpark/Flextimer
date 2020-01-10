//
//  HistoryDateCheckView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDateCheckView: UIView {
  
  let currentYearMonthButton = UIButton().then {
    $0.setTitle("2019년 1월", for: .normal)
    $0.setTitleColor(Color.secondText, for: .normal)
    $0.titleLabel?.font = Font.REGULAR_16
    $0.backgroundColor = .clear
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.addSubview(self.currentYearMonthButton)
    self.currentYearMonthButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.leading.equalToSuperview().offset(20)
//      $0.trailing.equalToSuperview().offset(20)
      $0.bottom.equalToSuperview().offset(-4)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
