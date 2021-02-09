//
//  TabBarControllerReactor.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/01/17.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import Foundation

import ReactorKit

class TabBarControllerReactor: Reactor {
    
    typealias Action = NoAction
    
    typealias Mutation = NoMutation
    
    struct State { }
    
    var initialState: State {
        return .init()
    }
    
    let provider : ManagerProviderType
    
    init(provider: ManagerProviderType) {
        self.provider = provider
    }
}


extension TabBarControllerReactor {
    
    func reactorForTodayViewController() -> TodayViewControllerReactor {
        return TodayViewControllerReactor(provider: self.provider)
    }
}

