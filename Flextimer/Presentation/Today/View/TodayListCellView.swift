//
//  TodayListCellView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class TodayListCellView: UIView {
  
  enum Text {
    static let HDVM_START = "HDVM_START".localized
  }
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.font = Font.REGULAR_16
  }
  
  let containerStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
  }
  
  let descriptionLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.font = Font.REGULAR_16
  }
  
  let editButton = UIButton().then {
    $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    $0.imageView?.tintColor = Color.secondaryText
    $0.isHidden = true
  }
  
  let separatorView = UIView().then {
    $0.backgroundColor = Color.separatorGray
  }
  
  init(_ title: String, description: String, color: UIColor) {
    super.init(frame: .zero)
    
    self.titleLabel.text = title
    self.titleLabel.textColor = color
    self.descriptionLabel.text = description
    self.descriptionLabel.textColor = color
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.containerStackView)
    self.addSubview(self.separatorView)
    
    self.titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
    }
    self.containerStackView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8)
      $0.trailing.equalToSuperview().offset(-20)
    }
    self.editButton.snp.makeConstraints {
      $0.size.equalTo(24)
    }
    
    self.containerStackView.addArrangedSubview(self.descriptionLabel)
    self.containerStackView.addArrangedSubview(self.editButton)

    self.separatorView.snp.makeConstraints {
      $0.height.equalTo(0.5)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.bottom.equalToSuperview()
    }
    
    if (title == Text.HDVM_START) {
      self.editButton.isHidden = false
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
