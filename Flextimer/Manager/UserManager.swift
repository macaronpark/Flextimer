//
//  UserManager.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/01/17.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import Foundation

protocol UserManagerType: class {
    var userInfo: UserInfo { get }
}

class UserManager: BaseManager, UserManagerType {
    
    // MARK: - Property
    
    var userInfo: UserInfo {
        let userInfo = RealmService
            .shared.realm
            .objects(UserInfo.self)
            .filter("id == 0")
            .last
        
        return userInfo ?? newUserInfo()
    }
    
    
    // MARK: - Method
    
    func newUserInfo() -> UserInfo {
        let newUserInfo = UserInfo(
            [0, 1, 2, 3, 4],
            hourOfWorkhoursADay: 9,
            minuteOfWorkhoursADay: 0
        )
        
        RealmService.shared.create(newUserInfo)
        return newUserInfo
    }
    

}
