//
//  TodayButtonsView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class TodayButtonsView: UIView {
  
  let startButton = UIButton().then {
    $0.setBackgroundColor(color: Color.immutableOrange, forState: .normal)
    $0.setBackgroundColor(color: Color.buttonGray, forState: .disabled)
    $0.setTitleColor(Color.immutableWhite, for: .normal)
    $0.setTitleColor(Color.immutableLightGray, for: .disabled)
    $0.layer.cornerRadius = 10
    $0.clipsToBounds = true
    $0.setTitle("출근", for: .normal)
  }
  
  let endButton = UIButton().then {
    $0.setBackgroundColor(color: Color.immutableOrange, forState: .normal)
    $0.setBackgroundColor(color: Color.buttonGray, forState: .disabled)
    $0.setTitleColor(Color.immutableWhite, for: .normal)
    $0.setTitleColor(Color.immutableLightGray, for: .disabled)
    $0.layer.cornerRadius = 10
    $0.clipsToBounds = true
    $0.setTitle("퇴근", for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.startButton)
    self.addSubview(self.endButton)
    
    self.startButton.snp.makeConstraints {
      $0.leading.top.bottom.equalToSuperview()
      $0.height.equalTo(48)
      $0.width.equalTo((ScreenSize.width - 56) / 2)
    }
    self.endButton.snp.makeConstraints {
      $0.top.equalTo(self.startButton)
      $0.leading.equalTo(self.startButton.snp.trailing).offset(16)
      $0.trailing.equalToSuperview()
      $0.height.equalTo(48)
      $0.width.equalTo((ScreenSize.width - 56) / 2)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension Reactive where Base: TodayButtonsView {
  
//  var viewModel: Binder<TodayViewModel> {
//    return Binder(self.base) { base, viewModel in
//      base.startButton.isEnabled = (viewModel.isWorking) ? false: true
//      base.endButton.isEnabled = (viewModel.isWorking) ? true: false
//    }
//  }
  
  var viewModel: Binder<Bool> {
    return Binder(self.base) { base, isWorking in
      base.startButton.isEnabled = (isWorking) ? false: true
      base.endButton.isEnabled = (isWorking) ? true: false
    }
  }
  
//  var isWorking: Binder<Bool> {
//    return Binder(self.base) { base, isWorking in
//      base.startButton.isEnabled = !isWorking
//      base.endButton.isEnabled = isWorking
//    }
//  }
}
