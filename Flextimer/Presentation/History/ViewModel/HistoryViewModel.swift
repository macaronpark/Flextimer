//
//  HistoryViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/18.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class HistroySectionModel {
  let rows: [HistoryCellModel]
  
  init(_ models: [HistoryCellModel]) {
    self.rows = models
  }
}

class HistoryViewModel {
  
  var sections: [HistroySectionModel]
  
  init(_ models: [HistroySectionModel]) {
    self.sections = models
  }
}
