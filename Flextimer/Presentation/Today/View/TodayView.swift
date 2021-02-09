//
//  TodayView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import Then
import ReactorKit

class TodayView: UIView, ReactorKit.View {
    
    var disposeBag = DisposeBag()
    
    
    // MARK: - Property
    
    let optionView = OptionView()
    
    let buttonsView = TodayButtonsView()
    
    let timerView = TodayTimerView()
    
    let stackView = TodayListStackView()
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Bind
    
    func bind(reactor: TodayViewReactor) {
        self.optionView.reactor = reactor.reactorForOptionView()
    }
}


// MARK: - Constraints

extension TodayView {
    
    fileprivate func setupConstraints() {
        self.addSubview(optionView)
        self.optionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(buttonsView)
        self.buttonsView.snp.makeConstraints {
            $0.top.equalTo(self.optionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(stackView)
        self.stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        self.addSubview(timerView)
        self.timerView.snp.makeConstraints {
            $0.top.equalTo(self.buttonsView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.stackView.snp.top)
        }
        
    }
}
