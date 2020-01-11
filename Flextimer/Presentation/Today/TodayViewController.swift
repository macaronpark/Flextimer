//
//  TodayViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class TodayViewController: BaseViewController {
  
  let settingBarButton = UIBarButtonItem(
    image: UIImage(named: "navi_setting")?.withRenderingMode(.alwaysOriginal),
    style: .plain,
    target: nil,
    action: nil
  )
  
  let todayView = TodayView()
  
  
  // MARK: - Lifecycles
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.todayView)
    self.todayView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "오늘의 근태"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.setRightBarButton(self.settingBarButton, animated: true)
  }
  
  
  // MARK: - Bind
  override func bind() {
    super.bind()
    
    self.settingBarButton.rx.tap
      .map { UINavigationController(rootViewController: SettingViewController()) }
      .bind { [weak self] in
        self?.navigationController?.present($0, animated: true, completion: nil)
    }
    .disposed(by: self.disposeBag)
  }
}
