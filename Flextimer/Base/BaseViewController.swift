//
//  BaseViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  let disposeBag = DisposeBag()

  lazy private(set) var className: String = {
    return type(of: self).description().components(separatedBy: ".").last ?? ""
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    Logger.debug("DEINIT: \(self.className)")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Color.systemBackground
    self.setupConstraints()
    self.bind()
  }
  
  func setupConstraints() {
    // override point
  }
  
  func bind() {
    // override point
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setupNaviBar()
  }
  
  func setupNaviBar() {
    // override point
  }
}
