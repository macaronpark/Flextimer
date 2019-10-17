//
//  UIButton.swift
//  Widget
//
//  Created by Suzy Park on 2019/10/18.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension UIButton {
  
  func setBackgroundColor(color: UIColor, forState: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.setBackgroundImage(colorImage, for: forState)
  }
}
