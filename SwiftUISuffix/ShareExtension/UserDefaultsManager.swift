//
//  UserDefaultsManager.swift
//  ShareExtension
//
//  Created by Анастасия on 30.10.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation

protocol UserDefaultsManagerAnyKey {
    var rawValue: String { get }
}

protocol UserDefaultsCodable {
    func encode(to defaults: UserDefaults, with key: String)
    static func decode(from defaults: UserDefaults, with key: String) -> Self?
}

class UserDefaultsManager {
    
    enum ArrayKey: String, UserDefaultsManagerAnyKey, CaseIterable {
        case history = "sharedHistoryKey"
    }
    
    static let shared = UserDefaultsManager(UserDefaults.standard)
    
    private let defaults: UserDefaults
    
    var allKeys: [UserDefaultsManagerAnyKey] {
        let unflatten: [[UserDefaultsManagerAnyKey]] = [
            ArrayKey.allCases
        ]
        
        return unflatten.flatMap({ $0 })
    }
    
    init(_ defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    // MARK: - Array of String
    
    subscript(_ key: ArrayKey) -> [Any]? {
        get {
            if defaults.object(forKey: key.rawValue) == nil {
                return nil
            } else {
                return defaults.array(forKey: key.rawValue)
            }
        }
        set {
            if let newValue = newValue {
                var isCorrectType: Bool = false
                if let firstElement = newValue.first {
                    switch firstElement {
                    case is NSString, is NSNumber, is NSData, is NSDate:
                        isCorrectType = true
                    default:
                        isCorrectType = false
                    }
                }
                if isCorrectType {
                    defaults.set(newValue, forKey: key.rawValue)
                } else {
                    defaults.set([], forKey: key.rawValue)
                }
            } else {
                defaults.removeObject(forKey: key.rawValue)
            }
        }
    }
    
    subscript(_ key: ArrayKey, default default: @autoclosure () -> [Any]) -> [Any] {
        return defaults.array(forKey: key.rawValue) ?? `default`()
    }
    
    // MARK: Remove
    
    func remove(_ keys: [UserDefaultsManagerAnyKey]) {
        for key in keys {
            self.defaults.removeObject(forKey: key.rawValue)
        }
    }
}
