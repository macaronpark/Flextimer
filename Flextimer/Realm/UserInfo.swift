//
//  UserInfo.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/27.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class UserInfo: Object {
  
  let workdays = List<Int>()
  @objc dynamic var workingHours: Int = 9
  
  convenience init(_ workdays: [Int], workingHours: Int) {
    self.init()
    self.workdays.append(objectsIn: workdays)
    self.workingHours = workingHours
  }
}
