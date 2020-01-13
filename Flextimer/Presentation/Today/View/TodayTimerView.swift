//
//  TodayTimerView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TodayTimerView: UIView {
  
  let descriptionLabel = UILabel().then {
    $0.font = Font.REGULAR_16
    $0.textColor = Color.grayText
    $0.adjustsFontSizeToFitWidth = true
    $0.textAlignment = .center
    $0.text = "근무를 시작하려면 '출근'버튼을 눌러주세요"
  }
  
  let timerLabel = UILabel().then {
    $0.font = Font.REGULAR_60
    $0.textColor = Color.immutableOrange
    $0.adjustsFontSizeToFitWidth = true
    $0.textAlignment = .center
    $0.text = "00:00:00"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.descriptionLabel)
    self.addSubview(self.timerLabel)
    
    self.descriptionLabel.snp.makeConstraints {
      $0.bottom.equalTo(self.snp.centerY).offset(-2)
      $0.leading.trailing.equalToSuperview()
    }
    self.timerLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.centerY).offset(2)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension Reactive where Base: TodayTimerView {
  var viewModel: Binder<TimeInterval> {
    return Binder(self.base) { base, interval in
      base.timerLabel.text = (interval > 0) ? interval.toString(.total): "00:00:00"
      base.descriptionLabel.text = (interval > 0) ? "지금은 근무 중": "근무를 시작하려면 '출근'버튼을 눌러주세요"
    }
  }
}
