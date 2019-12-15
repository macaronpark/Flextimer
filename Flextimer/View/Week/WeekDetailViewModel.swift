//
//  WeekDetailViewModel.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/11/14.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import Combine

class WeekDetailViewModel: ObservableObject {
  
  @Published var startDate: Date = Date()
  @Published var endDate: Date = Date()
  
  var isStartEdited = false
  var isEndEdited = false
  
  var realmObject: WorkRecord = WorkRecord()
  
  let record = PassthroughSubject<WorkRecord, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    record.sink { (record) in
      self.startDate = record.date
      self.endDate = record.endDate ?? Date()
      self.realmObject = record
      
      self.isEndEdited = false
      self.isStartEdited = false
    }.store(in: &cancellables)
    
    $startDate.sink { _ in
      self.isStartEdited = true
    }.store(in: &cancellables)
    
    $endDate.sink { _ in
      self.isEndEdited = true
    }.store(in: &cancellables)
    
  }
  
  enum DateType {
    case start
    case end
  }
}
