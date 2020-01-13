//
//  Logger.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class Logger {
  
  class func err(_ err: Error, _ str: String = "") {
    #if DEBUG
    debugPrint("🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻")
    debugPrint("🚨 \(#file)\n\(#function)\n\(#line)\n\(err.localizedDescription)\n\(err)\n\(str)")
    debugPrint("🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺")
    #endif
  }
  
  class func complete(_ str: String) {
    #if DEBUG
    debugPrint("🙆🏽‍♂️ \(str)")
    #endif
  }
  
  class func fail(_ str: String) {
    #if DEBUG
    debugPrint("🙅🏽‍♂️ \(str)")
    #endif
  }
  
  class func request(_ str: String) {
    #if DEBUG
    print("🙋🏽‍♂️ \(str)")
    #endif
  }
  
  class func disposed(_ str: String) {
    #if DEBUG
    debugPrint("🎒 \(str)")
    #endif
  }
  
  class func debug(_ str: String) {
    #if DEBUG
    debugPrint("⚠️ \(str)")
    #endif
  }
}
