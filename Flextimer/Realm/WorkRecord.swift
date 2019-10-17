//
//  WorkRecord.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class WorkRecord: Object {
  
  @objc dynamic var date: Date = Date()
  @objc dynamic var endDate: Date? = nil
  
  convenience init(_ date: Date, endDate: Date? = nil) {
    self.init()
    self.date = date
    if endDate != nil {
      self.endDate = endDate
    }
  }
}
