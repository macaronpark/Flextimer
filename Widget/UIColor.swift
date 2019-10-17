//
//  UIColor.swift
//  Widget
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
    self.init(
      red: CGFloat(r) / 255.0,
      green: CGFloat(g) / 255.0,
      blue: CGFloat(b) / 255.0,
      alpha: a
    )
  }
  
  convenience init(rgb: Int, a: CGFloat = 1.0) {
    self.init(
      red: CGFloat(rgb) / 255.0,
      green: CGFloat(rgb) / 255.0,
      blue: CGFloat(rgb) / 255.0,
      alpha: a
    )
  }
  
  public convenience init(hex : String){
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  static let orange = UIColor(hex: "F8613B")
}
