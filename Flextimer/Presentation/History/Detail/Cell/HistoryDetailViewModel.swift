//
//  HistoryDetailViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailCellModel {
  let title: String
  let isEditable: Bool?
  let isHoliday: Bool?
  let textColor: UIColor
  
  init(
    _ title: String,
    isEditable: Bool? = true,
    isHoliday: Bool? = false,
    textColor: UIColor = Color.primaryText
  ) {
    self.title = title
    self.isEditable = isEditable
    self.isHoliday = isHoliday
    self.textColor = textColor
  }
}

class HistoryDetailSectionModel {
  let sectionTitle: String?
  let rows: [HistoryDetailCellModel]
  let headerHeight: CGFloat
  
  init(
    _ rows: [HistoryDetailCellModel],
    sectionTitle: String? = nil,
    headerHeight: CGFloat = 60
  ) {
    self.rows = rows
    self.sectionTitle = sectionTitle
    self.headerHeight = headerHeight
  }
}

class HistoryDetailViewModel {
  let sections: [HistoryDetailSectionModel]
  
  init(_ workRecord: WorkRecord) {
    // 출근
    let startRows: [HistoryDetailCellModel] = [
      HistoryDetailCellModel(
        Formatter.dayName.string(from: workRecord.startDate),
        isEditable: false,
        isHoliday: workRecord.isHoliday,
        textColor: Color.grayText
      ),
      HistoryDetailCellModel(
        Formatter.shm.string(from: workRecord.startDate),
        isHoliday: workRecord.isHoliday
      )
    ]
    
    // 퇴근
    let endRows: [HistoryDetailCellModel] = [
      HistoryDetailCellModel(
        Formatter.dayName.string(from: workRecord.endDate ?? Date()),
        isHoliday: workRecord.isHoliday,
        textColor: Color.grayText
      ),
      HistoryDetailCellModel(
        Formatter.shm.string(from: workRecord.endDate ?? Date()),
        isHoliday: workRecord.isHoliday
      )
    ]
    
    // 휴무 처리
    let holidayRows: [HistoryDetailCellModel] = [
      HistoryDetailCellModel(
        "휴무 처리",
        isHoliday: workRecord.isHoliday,
        textColor: Color.grayText
      )
    ]
    
    // 기록 삭제
    let deleteRows: [HistoryDetailCellModel] = [
      HistoryDetailCellModel(
        "기록 삭제",
        textColor: Color.grayText
      )
    ]

    let startSection = HistoryDetailSectionModel(startRows, sectionTitle: "출근")
    let endSection = HistoryDetailSectionModel(endRows, sectionTitle: "퇴근")
    let holidaySection = HistoryDetailSectionModel(holidayRows, sectionTitle: "공휴일이거나 휴가라면? 휴무 처리 해 주세요")
    let deleteSection = HistoryDetailSectionModel(deleteRows, sectionTitle: " ", headerHeight: 30)
    
    self.sections = [
      startSection,
      endSection,
      holidaySection,
      deleteSection
    ]
  }
}
