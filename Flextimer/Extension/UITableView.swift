//
//  UITableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
    self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func dequeueCell<T: UITableViewCell>(
    ofType type: T.Type,
    indexPath: IndexPath
  ) -> T where T: ReusableView {
    return self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
  }
}

protocol ReusableView {
  static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
  
  static var defaultReuseIdentifier: String {
    return NSStringFromClass(self)
  }
}
