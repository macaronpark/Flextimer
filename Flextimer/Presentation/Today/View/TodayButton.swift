//
//  TodayButton.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/19.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class TodayButton: UIButton {
  
  init(_ title: String) {
    super.init(frame: .zero)
    
    self.titleLabel?.font = Font.SEMIBOLD_16
    self.setBackgroundColor(color: Color.immutableOrange, forState: .normal)
    self.setBackgroundColor(color: Color.buttonGray, forState: .disabled)
    self.setTitleColor(Color.immutableWhite, for: .normal)
    self.setTitleColor(Color.grayText, for: .disabled)
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
    self.setTitle(title, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
