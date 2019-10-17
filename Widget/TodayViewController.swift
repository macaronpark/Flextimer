//
//  TodayViewController.swift
//  Widget
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import NotificationCenter
import RealmSwift

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var endButton: UIButton!
  @IBOutlet weak var startTitleLabel: UILabel!
  @IBOutlet weak var startTimeLabel: UILabel!
  @IBOutlet weak var endTitleLabel: UILabel!
  @IBOutlet weak var remainTimeLabel: UILabel!
  @IBOutlet weak var alertLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupRealm()
    self.setupButtons()
    self.setupUI(RealmService.shared.isWorking())
  }
  
  fileprivate func setupRealm() {
    let fileURL = FileManager.default
    .containerURL(forSecurityApplicationGroupIdentifier: "group.com.suzypark.Flextimer")!
    .appendingPathComponent("shared.realm")
    Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
  }
  
  fileprivate func setupButtons() {
    [self.startButton,
     self.endButton].forEach {
      $0?.backgroundColor = UIColor.orange
      $0?.layer.cornerRadius = 6
    }
    self.startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
    self.endButton.addTarget(self, action: #selector(tapEndButton), for: .touchUpInside)
  }
  
  fileprivate func setupUI(_ isWorking: Bool) {
    // 출근 버튼 enable, backgroundColor
    self.startButton.isEnabled = isWorking ? false: true
    self.startButton.backgroundColor = isWorking ? .gray: .orange
    // 퇴근 버튼 enable, backgroundColor
    self.endButton.isEnabled = isWorking ? true: false
    self.endButton.backgroundColor = isWorking ? .orange: .gray
    // 출근 시간, 퇴근까지 남은 시간 타이틀, 디테일 라벨 표출
    self.startTitleLabel.isHidden = !isWorking
    self.startTimeLabel.isHidden = !isWorking
    self.endTitleLabel.isHidden = !isWorking
    self.remainTimeLabel.isHidden = !isWorking
    self.alertLabel.isHidden = true
    
    if isWorking {
      let record = RealmService.shared.realm.objects(WorkRecord.self).filter { $0.endDate == nil }
      if !record.isEmpty, let lastRecord = record.last {
        // 출근 시간 set
        self.startTimeLabel.text = Formatter.shm.string(from: lastRecord.date)
        // 퇴근까지 남은 시간 set
        let startInterval = Date().timeIntervalSince(lastRecord.date)
        /// todo: totalWorkingTime -> 설정 기능 들어가면 연동되게 바꾸기
        let totalWorkingTime = 9
        let totalInterval = totalWorkingTime.toTimeInterval()
        let remainInterval = totalInterval - startInterval
        // todo: 남은 시간 갱신은 위젯이 didLoad 될 때만 됨. 분 단위로 바꿀 수 있는 방법 알아보기
        self.remainTimeLabel.text = remainInterval.toString(.remain) + " 남았어요 (9시간 기준)"
      }
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
