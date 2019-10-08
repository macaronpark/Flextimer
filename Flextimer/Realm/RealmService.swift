//
//  RealmService.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func isWorking() -> Bool {
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: todayStart)!
        }()
        
        if RealmService.shared.realm.objects(WorkRecord.self)
            .filter("date BETWEEN %@", [todayStart, todayEnd]).count > 0 {
            return true
        }
        return false
    }
    
//    func post(_ error: Error) {
//        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
//    }
//
//    func observeRealmErrors(in vc: UIViewController, completion: @escaping(Error?) -> Void) {
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { notification in
//            completion(notification.object as? Error)
//        }
//    }
//
//    func stopObservingErrors(in vc: UIViewController) {
//        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
//    }
}
