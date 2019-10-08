//
//  Log.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class WorkRecord: Object {
  
  @objc dynamic var date: Date = Date()
  let hours = RealmOptional<Int>()
  
  convenience init(_ date: Date, hours: Int? = nil) {
    self.init()
    self.date = date
    self.hours.value = hours
  }
  
  //    func hoursString() -> String? {
  //        guard let hours = hours.value else { return nil }
  //        return String(hours)
  //    }
}
