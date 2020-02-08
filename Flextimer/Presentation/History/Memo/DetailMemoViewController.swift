//
//  DetailMemoViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/08.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class DetailMemoViewController: BaseViewController {
  
  let textView = UITextView().then {
    $0.font = Font.REGULAR_16
    $0.textColor = Color.primaryText
    $0.isScrollEnabled = true
  }

  lazy var doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(test), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(test), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.textView)
    self.textView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if self.textView.text.count == 0 {
      self.textView.becomeFirstResponder()
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.navigationItem.largeTitleDisplayMode = .never
    self.navigationItem.rightBarButtonItem = doneBarButton
  }
  
  override func bind() {
    super.bind()
    
    self.doneBarButton.rx.tap.subscribe(onNext: { [weak self] _ in
      self?.view.endEditing(true)
    }).disposed(by: self.disposeBag)
    
    
    
  }
  
  @objc func test(_ notification: Notification) {
    let userInfo = notification.userInfo!
    let keyboardHeight = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.height
    let isShow = (notification.name == UIResponder.keyboardWillShowNotification)
    let offset = isShow ? -(keyboardHeight): 0
    self.setNavigationBarButtonItem(isShow)
  
    DispatchQueue.main.async {
      self.textView.snp.updateConstraints {
        $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(offset)
      }
    }
  }
  
  func setNavigationBarButtonItem(_ isKeyboardShown: Bool) {
    let barButton: UIBarButtonItem? = isKeyboardShown ? self.doneBarButton: nil
    self.navigationItem.rightBarButtonItem = barButton
  }
}
