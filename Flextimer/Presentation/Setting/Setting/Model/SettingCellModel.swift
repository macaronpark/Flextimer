//
//  SettingCellModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class SettingCellModel {
  
  let title: String?
  
  let component: CellComponent
  
  var text: String?
  
  init(_ title: String? = nil, text: String? = nil, component: CellComponent) {
    self.title = title ?? ""
    self.text = text ?? ""
    self.component = component
  }
}
