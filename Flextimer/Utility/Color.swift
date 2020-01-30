//
//  Color.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import UIKit

enum Color {
  
  static let systemBackground = UIColor.systemBackground
  
  static let primaryText = UIColor.label
  
  static let secondaryText = UIColor.secondaryLabel

  static let buttonGray = UIColor.systemFill
  
  static let pickerGray = UIColor.tertiarySystemGroupedBackground
  
  static let immutableOrange = UIColor(hex: "F8613B")
  
  static let immutableWhite = UIColor(hex: "ffffff")
  
  static let immutableLightGray = UIColor.lightGray
  
  static let immutableTutorialBackground = UIColor(hex: "1A1817")
  
  static var separatorGray: UIColor = {
    if #available(iOS 13, *) {
      return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
        if UITraitCollection.userInterfaceStyle == .dark {
          return UIColor(hex: "3D3E41")
        }
        return UIColor(hex: "C6C6C8")
      }
    } else {
      /// Return a fallback color for iOS 12 and lower.
      return UIColor.darkGray.withAlphaComponent(0.4)
    }
  }()
}
