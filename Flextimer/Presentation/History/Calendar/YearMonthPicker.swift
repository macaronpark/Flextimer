//
//  MonthYearPicker.swift
//
//  Created by Ben Dodson on 15/04/2015.
//  Modified by Jiayang Miao on 24/10/2016 to support Swift 3
//  Modified by David Luque on 24/01/2018 to get default date
//
import UIKit

class YearMonthPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
  
  var years: [Int]!
  var months: [Int]!
  
  var year = Calendar.current.component(.year, from: Date()) {
    didSet {
      selectRow(years.firstIndex(of: year)!, inComponent: 1, animated: true)
    }
  }
  
  var month = Calendar.current.component(.month, from: Date()) {
    didSet {
      selectRow(month-1, inComponent: 0, animated: false)
    }
  }
  
  var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonSetup()
  }
  
  func commonSetup() {
    // population years
    var years: [Int] = []
    
    if years.count == 0 {
      
      let year = Calendar.current.component(.year, from: Date())
      
      let oldestRecordDate = RealmService.shared.realm
        .objects(WorkRecord.self)
        .sorted(by: { $0.startDate < $1.startDate })
        .first
        .flatMap { $0.startDate }
      
      let oldestYear = Calendar.current.component(.year, from: oldestRecordDate ?? Date())
      
      var tempYear = oldestYear
      for _ in oldestYear...year {
        years.append(tempYear)
        tempYear += 1
      }
    }
    
    self.years = years
    
    // population months
    var months: [Int] = []
    var month = 1
    for _ in 1...12 {
      // months.append(DateFormatter().monthSymbols[month].capitalized)
      months.append(month)
      month += 1
    }
    self.months = months
    
    self.delegate = self
    self.dataSource = self
    
    let currentComponents = Calendar.current.dateComponents([.year, .month], from: Date())
    
    if let currentYear = currentComponents.year,
      let yearIdx = years.firstIndex(of: currentYear),
      let currentMonth = currentComponents.month {
      
      self.selectRow(yearIdx, inComponent: 0, animated: true)
      self.selectRow(currentMonth - 1, inComponent: 1, animated: false)
    }
  }
  
  // Mark: UIPicker Delegate / Data Source
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch component {
    case 0:
      return "\(years[row])"
      
    case 1:
      return "\(months[row])"
      
    default:
      return nil
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return years.count
      
    case 1:
      return months.count
      
    default:
      return 0
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let month = years[self.selectedRow(inComponent: 1)]
    let year = self.selectedRow(inComponent: 0)+1
    
    if let block = onDateSelected {
      block(month, year)
    }
    
    self.month = month
    self.year = year
  }
}
