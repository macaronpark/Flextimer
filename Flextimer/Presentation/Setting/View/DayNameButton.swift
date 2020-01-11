//
//  DayNameButton.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class DayNameButton: UIButton {
  
  init(_ title: String) {
    super.init(frame: .zero)
    self.setBackgroundColor(color: Color.immutableOrange, forState: .selected)
    self.setBackgroundColor(color: Color.immutableLightGray, forState: .normal)
    self.setTitle(title, for: .normal)
    self.setTitleColor(Color.primaryText, for: .normal)
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
    self.translatesAutoresizingMaskIntoConstraints = false
    self.widthAnchor.constraint(equalToConstant: (ScreenSize.width-100)/7).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func selectedUpdate() {
    self.isSelected = !isSelected
  }
}
