//
//  PickerView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class PickerView: UIView {
  
  let picker = UIPickerView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.layer.cornerRadius = 20
    self.backgroundColor = Color.pickerGray
    
    self.addSubview(self.picker)
    self.picker.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
