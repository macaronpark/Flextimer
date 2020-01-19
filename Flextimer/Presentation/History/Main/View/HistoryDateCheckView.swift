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
    $0.setTitle(Formatter.yyyyMM.string(from: Date()), for: .normal)
    $0.setTitleColor(Color.immutableOrange, for: .normal)
    $0.titleLabel?.font = Font.SEMIBOLD_16
    $0.backgroundColor = Color.buttonGray
    $0.layer.cornerRadius = 18
  }
  
  let todayButton = UIButton().then {
    $0.setTitle("오늘", for: .normal)
    $0.setTitleColor(Color.immutableOrange, for: .normal)
    $0.titleLabel?.font = Font.SEMIBOLD_16
    $0.backgroundColor = Color.buttonGray
    $0.layer.cornerRadius = 18
  }
  
  let separatorView = UIView().then {
    $0.backgroundColor = Color.separatorGray
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.addSubview(self.currentYearMonthButton)
    self.addSubview(self.todayButton)
    self.addSubview(self.separatorView)
    
    self.todayButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-20)
      $0.size.equalTo(CGSize(width: 60, height: 36))
    }
    self.currentYearMonthButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalTo(self.todayButton.snp.leading).offset(-8)
      $0.size.equalTo(CGSize(width: 120, height: 36))
    }
    self.separatorView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(0.5)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
