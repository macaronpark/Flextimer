//
//  TodayListCellView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class TodayListCellView: UIView {
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.text = "출근"
  }
  
  let descriptionLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.text = "오전 9시 30분"
  }
  
  let separatorView = UIView().then {
    $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
  }
  
  init(_ title: String, description: String, color: UIColor) {
    super.init(frame: .zero)
    
    self.titleLabel.text = title
    self.titleLabel.textColor = color
    
    self.descriptionLabel.text = description
    self.descriptionLabel.textColor = color
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.descriptionLabel)
    self.addSubview(self.separatorView)
    
    self.titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
    }
    
    self.descriptionLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-20)
      $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8)
    }
    
    self.separatorView.snp.makeConstraints {
      $0.height.equalTo(0.5)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.bottom.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
