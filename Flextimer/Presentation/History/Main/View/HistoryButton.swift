//
//  HistoryButton.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/20.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryButton: UIButton {
  
  init() {
    super.init(frame: .zero)
    
    self.setTitleColor(Color.immutableOrange, for: .normal)
    self.titleLabel?.font = Font.SEMIBOLD_16
    self.backgroundColor = Color.buttonGray
    self.layer.cornerRadius = 18
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
