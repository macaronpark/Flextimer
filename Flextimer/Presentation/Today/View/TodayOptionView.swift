//
//  TodayOptionView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class TodayOptionView: UIView {
  
  let hourOfworkhoursPerDayLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.secondaryText
  }
  
  let minuteOfworkhoursPerDayLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.secondaryText
  }
  
  let firstSeparatorLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.secondaryText
    $0.text = " ・ "
  }
  
  let workdaysPerWeekLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.secondaryText
  }
  
  let secondSeparatorLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.secondaryText
    $0.text = " ・ "
  }
  
  let totalWorkhoursPerWeekLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.secondaryText
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.hourOfworkhoursPerDayLabel)
    self.addSubview(self.minuteOfworkhoursPerDayLabel)
    self.addSubview(self.firstSeparatorLabel)
    self.addSubview(self.workdaysPerWeekLabel)
    self.addSubview(self.secondSeparatorLabel)
    self.addSubview(self.totalWorkhoursPerWeekLabel)
    
    self.hourOfworkhoursPerDayLabel.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
    }
    self.minuteOfworkhoursPerDayLabel.snp.makeConstraints {
      $0.top.equalTo(self.hourOfworkhoursPerDayLabel)
      $0.leading.equalTo(self.hourOfworkhoursPerDayLabel.snp.trailing)
    }
    self.firstSeparatorLabel.snp.makeConstraints {
      $0.top.equalTo(self.hourOfworkhoursPerDayLabel)
      $0.leading.equalTo(self.minuteOfworkhoursPerDayLabel.snp.trailing)
    }
    self.workdaysPerWeekLabel.snp.makeConstraints {
      $0.top.equalTo(self.hourOfworkhoursPerDayLabel)
      $0.leading.equalTo(self.firstSeparatorLabel.snp.trailing)
    }
    self.secondSeparatorLabel.snp.makeConstraints {
      $0.top.equalTo(self.hourOfworkhoursPerDayLabel)
      $0.leading.equalTo(self.workdaysPerWeekLabel.snp.trailing)
    }
    self.totalWorkhoursPerWeekLabel.snp.makeConstraints {
      $0.top.equalTo(self.hourOfworkhoursPerDayLabel)
      $0.leading.equalTo(self.secondSeparatorLabel.snp.trailing)
      $0.trailing.lessThanOrEqualTo(self)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension Reactive where Base: TodayOptionView {
  var updateUI: Binder<TodayViewModel?> {
    return Binder(self.base) { base, viewModel in
      guard let viewModel = viewModel else { return }
      base.hourOfworkhoursPerDayLabel.text = viewModel.hourOfWorkhoursADay
      base.minuteOfworkhoursPerDayLabel.text = viewModel.minuteOfWorkhoursADay
      base.workdaysPerWeekLabel.text = viewModel.numberOfWorkdaysAWeek
      base.totalWorkhoursPerWeekLabel.text = viewModel.totalWorkhours
    }
  }
}
