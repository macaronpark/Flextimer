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
  
  let startCell = TodayListCellView("출근", description: "오전 9시 30분", color: Color.secondText)
  let endCell = TodayListCellView("퇴근 예상", description: "오후 6시 30분", color: Color.primaryText)
  let remainTimeCell = TodayListCellView("남은시간", description: "3시간 20분 33초", color: Color.immutableOrange)
  
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
      base.remainTimeCell.descriptionLabel.text = viewModel.remainTime
    }
  }
}
