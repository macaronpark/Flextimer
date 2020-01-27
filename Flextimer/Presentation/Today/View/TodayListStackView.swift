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
  
  let startCellButton = UIButton().then {
    $0.backgroundColor = .clear
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.axis = .vertical
    
    self.startCell.addSubview(self.startCellButton)
    self.startCell.snp.makeConstraints {
      $0.height.equalTo(48)
      $0.width.equalTo(ScreenSize.width)
    }
    self.startCellButton.snp.makeConstraints {
      $0.edges.equalToSuperview()
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
  var viewModel: Binder<(viewModel: TodayViewModel, isWorking: Bool)> {
    return Binder(self.base) { base, model in
      base.startCell.descriptionLabel.text = (model.isWorking) ? model.viewModel.startTime: "--:--"
      base.endCell.descriptionLabel.text = (model.isWorking) ? model.viewModel.endTime: "--:--"
      let remains = self.remains(from: model.viewModel.workRecordOfToday?.startDate)
      base.remainTimeCell.descriptionLabel.text = (model.isWorking) ? remains: "--:--"
    }
  }
  
  func remains(from date: Date?) -> String {
    guard let date = date else {
      return "--:--"
    }
    
    let interval = Date().timeIntervalSince(date).rounded()
    // 남은 시간: 일일 근무 시간 - interval
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkHourInterval = h + m
    let remainInterval = totalWorkHourInterval - interval
    
    if remainInterval.isZero {
      return remainInterval.toString(.remain) + " 클리어!"
    } else if remainInterval.isLess(than: 0.0) {
      if (-remainInterval).toString(.remain) == "0시간 0분" {
        return remainInterval.toString(.remain) + " 클리어!"
      }
      return (-remainInterval).toString(.remain) + "째 초과근무 중"
    } else {
      return remainInterval.toString(.remain) + " 남았어요"
    }
  }
}
