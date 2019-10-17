//
//  TodayViewController.swift
//  Widget
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var endButton: UIButton!
  @IBOutlet weak var startTitleLabel: UILabel!
  @IBOutlet weak var endTitleButton: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setButtonsCornerRadious()
    // Do any additional setup after loading the view.
  }
  
  fileprivate func setButtonsCornerRadious() {
    [self.startButton,
     self.endButton].forEach {
      $0?.backgroundColor = UIColor.orange
      $0?.layer.cornerRadius = 6
    }
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    completionHandler(NCUpdateResult.newData)
  }
  
}
