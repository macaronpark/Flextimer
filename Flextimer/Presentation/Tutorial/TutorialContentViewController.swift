//
//  TutorialContentViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/30.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TutorialContentViewController: BaseViewController {
  
  private(set) var viewModel: TutorialViewModel!
    
  lazy var imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var titleLabel = UILabel().then {
    $0.font = Font.SEMIBOLD_24
    $0.textColor = Color.immutableWhite
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
  }
  
  lazy var contentLabel = UILabel().then {
    $0.font = Font.REGULAR_18
    $0.textColor = Color.immutableLightGray
    $0.numberOfLines = 0
  }
  
  
  // MARK: - Init
  
  override init() {
    super.init()
  }
  
  convenience init(_ viewModel: TutorialViewModel) {
    self.init()
    
    self.viewModel = viewModel
    self.bindUI(viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    
    self.imageView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.snp.centerY).offset(60)
      $0.height.equalTo(334)
    }
    self.titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.imageView.snp.bottom).offset(78)
      $0.leading.equalTo(self.view).offset(40)
      $0.trailing.equalTo(self.view).offset(-40)
    }
    self.contentLabel.snp.makeConstraints {
      $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
      $0.leading.equalTo(self.view).offset(20)
      $0.trailing.equalTo(self.view).offset(-20)
    }
  }
  
  func bindUI(_ viewModel: TutorialViewModel) {
    self.titleLabel.text = viewModel.title
    self.imageView.image = UIImage(imageLiteralResourceName: viewModel.imageName)
    
    let attributedString = NSMutableAttributedString(string: viewModel.content)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    paragraphStyle.alignment = .center
    attributedString.addAttribute(
      NSAttributedString.Key.paragraphStyle,
      value:paragraphStyle,
      range:NSMakeRange(0, attributedString.length)
    )
    
    self.contentLabel.attributedText = attributedString
  }
}
