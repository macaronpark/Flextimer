//
//  DetailMemoViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/08.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class DetailMemoViewController: BaseViewController {
  
  var workRecord: WorkRecord?
  
  let textView = UITextView().then {
    $0.font = Font.REGULAR_16
    $0.textColor = Color.primaryText
    $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    $0.isScrollEnabled = true
  }

  lazy var doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
  
  
  // MARK: - Init
  
  init(_ workRecord: WorkRecord) {
    super.init()
    
    self.workRecord = workRecord
    self.textView.text = workRecord.memo
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.textView)
    self.textView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if self.textView.text.count == 0 {
      self.textView.becomeFirstResponder()
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.navigationItem.largeTitleDisplayMode = .never
  }
  
  override func bind() {
    super.bind()
    
    self.textView.rx.text
      .skip(1)
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] text in
        guard let self = self,
          let text = text,
          let workRecord = self.workRecord else { return }
        
        RealmService.shared.update(
          workRecord,
          with: [WorkRecordEnum.memo.str: text]
        )
        
    }).disposed(by: self.disposeBag)
    
    self.doneBarButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.view.endEditing(true)
    }).disposed(by: self.disposeBag)
  }
  
  @objc func willShowKeyboard(_ notification: Notification) {
    self.setNavigationBarButtonItem(true)
    
    let userInfo = notification.userInfo!
    let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let tabBarHeight: CGFloat = self.tabBarController?.tabBar.frame.size.height ?? 0
    
    self.textView.contentInset.bottom = (keyboardRect.size.height - tabBarHeight) + 8
    self.textView.verticalScrollIndicatorInsets.bottom = keyboardRect.size.height
  }
  
  @objc func willHideKeyboard(_ notification: Notification) {
    self.setNavigationBarButtonItem(false)

    self.textView.contentInset.bottom = 16
    self.textView.verticalScrollIndicatorInsets.bottom = 16
  }
  
  func setNavigationBarButtonItem(_ isKeyboardShown: Bool) {
    let barButton: UIBarButtonItem? = isKeyboardShown ? self.doneBarButton: nil
    self.navigationItem.rightBarButtonItem = barButton
  }
}
