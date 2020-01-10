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
  let action: ((UINavigationController) -> Void)?
  var text: String?
  
  init(_ title: String? = nil, text: String? = nil, component: CellComponent, action: ((UINavigationController) -> Void)?) {
    
    if let title = title {
      self.title = title
    } else {
      self.title = nil
    }
    
    if let text = text {
      self.text = text
    } else {
      self.text = nil
    }
    
    self.text = text
    self.component = component
    self.action = action
  }
}
