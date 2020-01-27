//
//  History_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension HistoryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt
    indexPath: IndexPath)
  {
    if let workRecord = self.historyViewModel?.sections[indexPath.section].rows[indexPath.row].workRecord {
      let vc = HistoryDetailViewController(workRecord)
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let date = self.historyViewModel?.sections[indexPath.section].rows[indexPath.row].date ?? Date()
    let workRecord = self.historyViewModel?.sections[indexPath.section].rows[indexPath.row].workRecord
    
    let holidayAction = UIContextualAction(
      style: .normal,
      title: "휴무 처리",
      handler: { _, _, completion in
        
        let date = date
        
        if let workRecord = workRecord {
          RealmService.shared.update(workRecord, with: ["isHoliday": true])
          self.displayedDate.accept(workRecord.startDate)
        } else {
          // 기록이 없으면 만들어서
          let newWorkRecord = WorkRecord(date, endDate: date, isHoliday: true)
          RealmService.shared.create(newWorkRecord)
          self.displayedDate.accept(date)
        }
        completion(true)
    })
    
    let deleteAction = UIContextualAction(
      style: .destructive,
      title: "기록 삭제",
      handler: { _, _, completion in
        if let workRecord = workRecord {
          let date = workRecord.startDate
          RealmService.shared.delete(workRecord)
          self.displayedDate.accept(date)
        }
        completion(true)
    })
    
    let createAction = UIContextualAction(
      style: .normal,
      title: "기록 생성",
      handler: { _, _, completion in
        // 출근 시간은 임의로 오전 9시로 고정해서 설정
        let startDateHour = Calendar.current.date(
          byAdding: .hour,
          value: 9,
          to: date
        ) ?? Date()
        
        // 퇴근 시간은 유저의 근무 시간을 반영해서 설정
        let endDateHour = Calendar.current.date(
          byAdding: .hour,
          value: RealmService.shared.userInfo.hourOfWorkhoursADay,
          to: startDateHour
        ) ?? Date()
        
        let endDateHourMin = Calendar.current.date(
          byAdding: .minute,
          value: RealmService.shared.userInfo.minuteOfWorkhoursADay,
          to: endDateHour
        ) ?? Date()
        
        let newWorkRecord = WorkRecord(startDateHour, endDate: endDateHourMin, isHoliday: false)
        RealmService.shared.create(newWorkRecord)
        self.displayedDate.accept(startDateHour)
        
        let vc = HistoryDetailViewController(newWorkRecord)
        self.navigationController?.pushViewController(vc, animated: true)
        
        completion(true)
    }).then {
      $0.backgroundColor = UIColor.systemBlue
    }
    
    let actionsForRecordNotExistCell = UISwipeActionsConfiguration(actions: [createAction, holidayAction])
    let actionsForRecordExistCell = UISwipeActionsConfiguration(actions: [deleteAction, holidayAction])
    let actionsForHolidayExistCell = UISwipeActionsConfiguration(actions: [deleteAction])
    let holiday = UISwipeActionsConfiguration(actions: [holidayAction])
    
    if let workRecord = workRecord {
      // 해당 일 기록이 있을 때
      // 휴무 처리가 아니라면 '휴무처리', '기록삭제'
      return (workRecord.isHoliday == true) ? actionsForHolidayExistCell: actionsForRecordExistCell
    } else {
      // 해당 일 기록이 없을 때
      // '오늘'이라면
      if (Calendar.current.isDateInToday(date) == true) {
        let currentWorkRecord = RealmService.shared.realm
          .objects(WorkRecord.self)
          .filter { (Calendar.current.isDateInToday($0.startDate)) }
          .last
        
        if let _ = currentWorkRecord {
          // 현재 근무 중이라면
          return nil
        }
        // 현재 근무 중이 아니라면
        return holiday
      }
      // '오늘'이 아닐 경우 '휴무처리', '기록생성'
      return actionsForRecordNotExistCell
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let id = "HistorySectionFooterView"
    let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: id) as? HistorySectionFooterView
    let section = self.historyViewModel?.sections[section]
    
    if let footerView = footerView,
      let section = section,
      section.rows.filter({ $0.workRecord != nil }).count > 0 {
      footerView.updateUI(section)
      return footerView
    }
    return nil
  }
}

extension HistoryViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.historyViewModel?.sections.count ?? 0
  }

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    return self.historyViewModel?.sections[section].rows.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueCell(ofType: HistoryTableViewCell.self, indexPath: indexPath)
    if let model = self.historyViewModel?.sections[indexPath.section].rows[indexPath.row] {
      cell.updateCell(model)
    }
    return cell
  }
}
