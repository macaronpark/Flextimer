//
//  TodayOptionView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import SnapKit
import Then
import ReactorKit
import RxSwift
import RxCocoa

class OptionView: UIView, ReactorKit.View {
    
    var disposeBag = DisposeBag()
    
    let hourLabel = UILabel().then {
        $0.font = Font.REGURAL_14
        $0.textColor = Color.secondaryText
    }
    
    let minuteLabel = UILabel().then {
        $0.font = Font.REGURAL_14
        $0.textColor = Color.secondaryText
    }
    
    let firstSeparatorLabel = UILabel().then {
        $0.font = Font.REGURAL_14
        $0.textColor = Color.secondaryText
        $0.text = " ・ "
    }
    
    let workdayLabel = UILabel().then {
        $0.font = Font.REGURAL_14
        $0.textColor = Color.secondaryText
    }
    
    let secondSeparatorLabel = UILabel().then {
        $0.font = Font.REGURAL_14
        $0.textColor = Color.secondaryText
        $0.text = " ・ "
    }
    
    let workhourLabel = UILabel().then {
        $0.font = Font.REGURAL_14
        $0.textColor = Color.secondaryText
    }
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Binding
    
    func bind(reactor: TodayOptionViewReactor) {
        
        reactor.action.onNext(.load)
        
        reactor.state.map { $0.hourText }
            .bind(to: self.hourLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.minuteText }
            .bind(to: self.minuteLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.workdayText }
            .bind(to: self.workdayLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.workhourText }
            .bind(to: self.workhourLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        self.addSubview(self.hourLabel)
        self.hourLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        self.addSubview(self.minuteLabel)
        self.minuteLabel.snp.makeConstraints {
            $0.top.equalTo(self.hourLabel)
            $0.leading.equalTo(self.hourLabel.snp.trailing)
        }
        
        self.addSubview(self.firstSeparatorLabel)
        self.firstSeparatorLabel.snp.makeConstraints {
            $0.top.equalTo(self.hourLabel)
            $0.leading.equalTo(self.minuteLabel.snp.trailing)
        }
        
        self.addSubview(self.workdayLabel)
        self.workdayLabel.snp.makeConstraints {
            $0.top.equalTo(self.hourLabel)
            $0.leading.equalTo(self.firstSeparatorLabel.snp.trailing)
        }
        
        self.addSubview(self.secondSeparatorLabel)
        self.secondSeparatorLabel.snp.makeConstraints {
            $0.top.equalTo(self.hourLabel)
            $0.leading.equalTo(self.workdayLabel.snp.trailing)
        }
        
        self.addSubview(self.workhourLabel)
        self.workhourLabel.snp.makeConstraints {
            $0.top.equalTo(self.hourLabel)
            $0.leading.equalTo(self.secondSeparatorLabel.snp.trailing)
            $0.trailing.lessThanOrEqualTo(self)
        }
    }
}
