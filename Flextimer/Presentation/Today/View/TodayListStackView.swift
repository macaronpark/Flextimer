//
//  TodayListStackView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TodayListStackView: UIStackView {
  
  let startCell = TodayListCellView("출근", description: "--:--", color: Color.secondText)
  let endCell = TodayListCellView("퇴근 예상", description: "--:--", color: Color.primaryText)
  let remainTimeCell = TodayListCellView("남은시간", description: "--:--", color: Color.immutableOrange)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.axis = .vertical
    
    self.startCell.snp.makeConstraints {
      $0.height.equalTo(48)
      $0.width.equalTo(ScreenSize.width)
    }
    self.endCell.snp.makeConstraints {
      $0.height.equalTo(48)
      $0.width.equalTo(ScreenSize.width)
    }
    self.remainTimeCell.snp.makeConstraints {
      $0.height.equalTo(48)
      $0.width.equalTo(ScreenSize.width)
    }
    self.remainTimeCell.separatorView.isHidden = true
    
    self.addArrangedSubview(self.startCell)
    self.addArrangedSubview(self.endCell)
    self.addArrangedSubview(self.remainTimeCell)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension Reactive where Base: TodayListStackView {
  var viewModel: Binder<TodayViewModel> {
    return Binder(self.base) { base, viewModel in
      base.startCell.descriptionLabel.text = viewModel.startTime
      base.endCell.descriptionLabel.text = viewModel.endTime
    }
  }
  
  var updateRemainTime: Binder<TimeInterval> {
    return Binder(self.base) { base, interval in
      // 총 근무 시간 == interval
      // 남은 근무 시간(픽스 근무 시간 - 총 근무 시간) 업데이트
      let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
      let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
      let totalWorkHourInterval = h + m
       let remainInterval = totalWorkHourInterval - interval
      
      if remainInterval.isLess(than: 0.0) {
        base.remainTimeCell.descriptionLabel.text = (-remainInterval).toString(.remain) + "째 초과근무 중"
      } else {
        base.remainTimeCell.descriptionLabel.text = remainInterval.toString(.remain) + " 남았어요"
      }
    }
  }
}
