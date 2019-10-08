//
//  Log.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

class Log {
  
  class func err(_ err: Error, _ str: String = "") {
    #if DEBUG
    debugPrint("🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻")
    debugPrint("🚨 \(#file)\n\(#function)\n\(#line)\n\(err.localizedDescription)\n\(err)\n\(str)")
    debugPrint("🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺")
    #endif
  }
  
  class func complete(_ str: String) {
    #if DEBUG
    debugPrint("🙆🏻‍♀️ \(str)")
    #endif
  }
  
  class func fail(_ str: String) {
    #if DEBUG
    debugPrint("🙅🏻‍♀️ \(str)")
    #endif
  }
  
  class func request(_ str: String) {
    #if DEBUG
    print("🙋🏻‍♀️ \(str)")
    #endif
  }

  class func debug(_ str: String) {
    #if DEBUG
    debugPrint("⚠️ \(str)")
    #endif
  }
}
