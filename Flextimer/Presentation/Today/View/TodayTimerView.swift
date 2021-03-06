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
  
  enum Text {
    static let TTV_DESCRIPTION = "TTV_DESCRIPTION".localized
  }
  
  let descriptionLabel = UILabel().then {
    $0.font = Font.REGULAR_16
    $0.textColor = Color.secondaryText
    $0.adjustsFontSizeToFitWidth = true
    $0.textAlignment = .center
    $0.text = Text.TTV_DESCRIPTION
  }
  
  let timerLabel = UILabel().then {
    $0.font = Font.THIN_60
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
  var viewModel: Binder<TodayViewModel> {
    return Binder(self.base) { base, viewModel in
      guard let startDate = viewModel.workRecordOfToday?.startDate else {
        base.timerLabel.text = "00:00:00"
        base.descriptionLabel.text = "TTV_DESCRIPTION".localized
        return
      }
      
      let interval = Date().timeIntervalSince(startDate).rounded()
      base.timerLabel.text = interval.toString(.total)
      base.descriptionLabel.text = "TTV_AT_WORK_RIGHT_NOW".localized
    }
  }
  
  var resetTimer: Binder<Bool> {
    return Binder(self.base) { base, interval in
      base.timerLabel.text = "00:00:00"
      base.descriptionLabel.text = "TTV_DESCRIPTION".localized
    }
  }
}
