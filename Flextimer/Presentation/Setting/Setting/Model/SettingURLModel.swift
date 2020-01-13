//
//  SettingURLModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class SettingURLModel {
  
  let indexPath: IndexPath
  
  init(_ indexPath: IndexPath) {
    self.indexPath = indexPath
  }
  
  var url: URL? {
    switch (self.indexPath.section, self.indexPath.row) {
    case (2, 0):
      return URL(string: "https://itunes.apple.com/app/id1484457501")
      
    case (2, 1):
      return URL(string: "https://github.com/macaronpark")
      
    case (2, 2):
      return URL(string: "https://www.notion.so/Opensources-5f23792b38334a17b6795a00dc20de7b")
      
    default:
      return nil
    }
  }
}
