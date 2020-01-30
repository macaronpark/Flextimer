//
//  TutorialContentViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/30.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class TutorialContentViewController: BaseViewController {
  
  var pageIndex: Int = 0
  var titleText: String = ""
  var contentText: String = ""
  var imageString: String = ""
  
  lazy var imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(imageLiteralResourceName: self.imageString)
  }
  
  lazy var titleLabel = UILabel().then {
    $0.text = self.titleText
    $0.font = Font.SEMIBOLD_24
    $0.textColor = Color.immutableWhite
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
  }
  
  lazy var contentLabel = UILabel().then {
    let attributedString = NSMutableAttributedString(string: self.contentText)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    attributedString.addAttribute(
      NSAttributedString.Key.paragraphStyle,
      value:paragraphStyle,
      range:NSMakeRange(0, attributedString.length)
    )
    $0.attributedText = attributedString
    $0.font = Font.REGULAR_18
    $0.textColor = Color.secondaryText
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  
  let skipButton = UIButton().then {
    $0.backgroundColor = UIColor.clear
    $0.setTitle("건너뛰기", for: .normal)
    $0.setTitleColor(Color.secondaryText.withAlphaComponent(0.2), for: .normal)
    $0.titleLabel?.font = Font.REGULAR_16
  }
  
  let startButton = HistoryButton().then {
    $0.setTitle("시작하기", for: .normal)
  }

  
  // MARK: - Init
  
  convenience init(_ tutorial: Tutorial) {
    self.init()
    
    self.pageIndex = tutorial.index
    self.titleText = tutorial.title
    self.contentText = tutorial.content
    self.imageString = tutorial.imageName
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupConstraints()
    self.view.backgroundColor = .clear
  }
  
  
  // MARK: - Constraints
  
  override func setupConstraints() {
    self.view.addSubview(self.imageView)
    self.view.addSubview(self.titleLabel)
    self.view.addSubview(self.contentLabel)
    self.view.addSubview(self.skipButton)
    self.view.addSubview(self.startButton)
    
    self.imageView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.snp.centerY).offset(60)
      $0.height.equalTo(334)
    }
    self.titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.imageView.snp.bottom).offset(88)
      $0.leading.equalTo(self.view).offset(40)
      $0.trailing.equalTo(self.view).offset(-40)
    }
    self.contentLabel.snp.makeConstraints {
      $0.top.equalTo(self.titleLabel.snp.bottom).offset(24)
      $0.leading.equalTo(self.view).offset(20)
      $0.trailing.equalTo(self.view).offset(-20)
    }
    self.skipButton.snp.makeConstraints {
      $0.trailing.equalTo(self.view).offset(-20)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
      $0.height.equalTo(36)
    }
    self.startButton.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 120, height: 40))
      $0.centerX.equalTo(self.view)
      $0.top.equalTo(self.contentLabel.snp.bottom).offset(24)
    }
  }
}
