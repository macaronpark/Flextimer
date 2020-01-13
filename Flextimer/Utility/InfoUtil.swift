//
//  InfoUtil.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class InfoUtil {

  static var versionDescription: String {
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
  }
}
