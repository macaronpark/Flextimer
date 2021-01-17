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
    
//    //TODO: 워크스페이스 - 서비스 요청
//    func reactorForWorkspaceHome() -> WorkspaceHomeReactor {
//        return WorkspaceHomeReactor(
//            provider: self.provider,
//            swsIdx: self.swsIdx,
//            pushInfo: self.pushInfo
//        )
//    }
//
//    //TODO: 워크스페이스 - 내 서비스
//    func reactorForMyServices() -> ServiceManagementViewReactor {
//        return ServiceManagementViewReactor(
//            provider: self.provider,
//            swsIdx: self.swsIdx,
//            pushInfo: self.pushInfo
//        )
//    }
//
//    //TODO: 워크스페이스  - 더보기
//    func reactorForMore() -> WorkspaceMoreViewReactor {
//        return WorkspaceMoreViewReactor(provider: self.provider, swsIdx: self.swsIdx)
//    }
}

