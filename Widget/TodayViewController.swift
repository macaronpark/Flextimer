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

// todo: Rx
class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var startButton: WidgetButton!
  @IBOutlet weak var endButton: WidgetButton!
  @IBOutlet weak var okButton: WidgetButton!
  @IBOutlet weak var cancelButton: WidgetButton!
  @IBOutlet weak var startTimeLabel: UILabel!
  @IBOutlet weak var remainTimeLabel: UILabel!
  @IBOutlet weak var alertLabel: UILabel!
  
  weak var timer: Timer?
  /// 위젯 레이아웃의 분단위 업데이트를 위한 기준 타임
  var timeCreteria = Date()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupRealm()
    self.setupButtons()
    self.setupUI(RealmService.shared.isWorking())
    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: true)
  }
  
  fileprivate func setupRealm() {
    let fileURL = FileManager.default
    .containerURL(forSecurityApplicationGroupIdentifier: "group.suzypark.Flextimer")!
    .appendingPathComponent("shared.realm")
    Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
  }
  
  fileprivate func setupButtons() {
    self.startButton.setBasicConfig(.start)
    self.endButton.setBasicConfig(.end)
//    self.okButton.setBasicConfig(.done)
//    self.cancelButton.setBasicConfig(.cancel)
    self.startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
    self.endButton.addTarget(self, action: #selector(tapEndButton), for: .touchUpInside)
//    self.okButton.addTarget(self, action: #selector(tapOkButton), for: .touchUpInside)
//    self.cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
  }

  fileprivate func setupUI(_ isWorking: Bool) {
    // todo: refactoring🤢🤮
    self.startButton.isEnabled = !isWorking
    self.endButton.isEnabled = isWorking
    // 출근 시간, 퇴근까지 남은 시간 타이틀, 디테일 라벨 표출
    self.startTimeLabel.isHidden = !isWorking
    self.remainTimeLabel.isHidden = !isWorking
    self.alertLabel.isHidden = true
    
    if isWorking {
      let record = RealmService.shared.realm.objects(WorkRecord.self).filter { $0.endDate == nil }
      if !record.isEmpty, let lastRecord = record.last {
        // 출근 시간 set
        self.startTimeLabel.text = "출근: \(Formatter.shm.string(from: lastRecord.date))"
        // 퇴근까지 남은 시간 set
        let startInterval = Date().timeIntervalSince(lastRecord.date)
        /// todo: totalWorkingTime -> 설정 기능 들어가면 연동되게 바꾸기
        let totalWorkingTime = 9
        let totalInterval = totalWorkingTime.toRoundedTimeInterval()
        let remainInterval = totalInterval - startInterval
        self.remainTimeLabel.text = "퇴근까지 \(remainInterval.toString(.remain)) 남았어요 (9시간 기준)"
      }
    }
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    self.setupUI(RealmService.shared.isWorking())
    completionHandler(NCUpdateResult.noData)
  }
}
