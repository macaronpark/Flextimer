//
//  History_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension HistoryViewController: UITableViewDelegate {
  
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
        if let workRecord = workRecord {
          RealmService.shared.update(workRecord, with: ["isHoliday": true])
          // TODO: reload
        } else {
          // TODO: 기록이 없으면 만들어서 reload
        }
        completion(true)
    })
    
    let deleteAction = UIContextualAction(
      style: .destructive,
      title: "기록 삭제",
      handler: { _, _, completion in
        if let workRecord = workRecord {
          RealmService.shared.delete(workRecord)
          // TODO: reload
        }
        completion(true)
    })
    
    let createAction = UIContextualAction(
      style: .normal,
      title: "기록 생성",
      handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
        // TODO: 기록이 만들어서 reload
    }).then {
      $0.backgroundColor = UIColor.systemBlue
    }
    
    let actionsForRecordNotExistCell = UISwipeActionsConfiguration(actions: [createAction, holidayAction])
    let actionsForRecordExistCell = UISwipeActionsConfiguration(actions: [deleteAction, holidayAction])
    let actionsForHolidayExistCell = UISwipeActionsConfiguration(actions: [deleteAction])
    let holiday = UISwipeActionsConfiguration(actions: [holidayAction])
    
    if let workRecord = workRecord {
      return (workRecord.isHoliday == true) ? actionsForHolidayExistCell: actionsForRecordExistCell
    } else {
      if (Calendar.current.isDateInToday(date) == true) {
        let d = RealmService.shared.realm.objects(WorkRecord.self).filter { (Calendar.current.isDateInToday($0.startDate)) }.last
        if let _ = d {
          return nil
        }
        return holiday
      }
      return actionsForRecordNotExistCell
    }
  }
}

extension HistoryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.historyViewModel?.sections.count ?? 0
  }
  
//  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 40
//  }
//
//  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//    return "총 근무 시간"
//  }
  
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
