//
//  Creteria.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine

class Creteria: ObservableObject {
  
  @Published var workDayCount = ["1", "2", "3", "4", "5", "6", "7"]
  
  var didChange = PassthroughSubject<Void, Never>()
  var count = 0 { didSet { update() }}
  
  func update() {
    didChange.send(())
  }
}
