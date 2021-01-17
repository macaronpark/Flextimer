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
    
    /// 유저 정보
    var userInfo: UserInfo {
        let userInfoArray = RealmService.shared.realm.objects(UserInfo.self).filter("id == 0")
        
        guard let userInfo = userInfoArray.last else {
            let newUserInfo = UserInfo(
                [0, 1, 2, 3, 4],
                hourOfWorkhoursADay: 9,
                minuteOfWorkhoursADay: 0
            )
            
            RealmService.shared.create(newUserInfo)
            return newUserInfo
        }
        
        return userInfo
    }
}
