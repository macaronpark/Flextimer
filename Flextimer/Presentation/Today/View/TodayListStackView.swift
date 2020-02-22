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
  
  enum Text {
    static let HDVM_START = "HDVM_START".localized
    static let TLSV_TO_LEAVE = "TLSV_END_PREDICT".localized
    static let TLSV_REMAINS = "TLSV_REMAINS".localized
  }
  
  let startCell = TodayListCellView(Text.HDVM_START, description: "--:--", color: Color.secondaryText)

  let endCell = TodayListCellView(Text.TLSV_TO_LEAVE, description: "--:--", color: Color.primaryText)
  
  let remainTimeCell = TodayListCellView(Text.TLSV_REMAINS, description: "--:--", color: Color.immutableOrange)
  
  let startCellButton = UIButton().then {
    $0.backgroundColor = .clear
  }
  
  
  // MARK: - Init
  
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
  var viewModel: Binder<(viewModel: TodayViewModel?, isWorking: Bool)> {
    return Binder(self.base) { base, model in
      guard let viewModel = model.viewModel else { return }
      base.startCell.editButton.isHidden = !model.isWorking
      base.startCell.descriptionLabel.text = (model.isWorking) ? viewModel.startTime: "--:--"
      base.endCell.descriptionLabel.text = (model.isWorking) ? viewModel.endTime: "--:--"
      
      // 위젯 퇴근 -> 히스토리에서 기록 삭제 시 터짐 방지 관련
      if let record = viewModel.workRecordOfToday {
        
        let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
        let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
        let totalWorkHourInterval = h + m
        
        let isLessRemainsThanWorkhoursADay = viewModel.isLessRemainsThanWorkhoursADay()
        
        if isLessRemainsThanWorkhoursADay.isLessRemains {
          
          if let remains = isLessRemainsThanWorkhoursADay.raminsInterval {
            if remains > 0 {
              base.remainTimeCell.descriptionLabel.text = "%@ left".localized(with: [remains.toString(.remain)])
            } else if remains.isZero {
              base.remainTimeCell.descriptionLabel.text = "%@ CLEAR!".localized(with: [totalWorkHourInterval.toString(.remain)])
            } else {
              base.remainTimeCell.descriptionLabel.text = "%@ OVER".localized(with: [(-remains).toString(.remain)])
            }
          }
          
        } else {
          let remains = self.remains(from: record.startDate)
          base.remainTimeCell.descriptionLabel.text = (model.isWorking) ? remains: "--:--"
        }
      } else {
        base.remainTimeCell.descriptionLabel.text = "--:--"
      }
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
      return "%@ CLEAR!".localized(with: [remainInterval.toString(.remain)])
    } else if remainInterval.isLess(than: 0.0) {
      if (-remainInterval).toString(.remain) == "0hrs 0min".localized {
        return "%@ CLEAR!".localized(with: [remainInterval.toString(.remain)])
      }
      return "%@ OVER".localized(with: [(-remainInterval).toString(.remain)])
    } else {
      return "%@ left".localized(with: [remainInterval.toString(.remain)])
    }
  }
}
