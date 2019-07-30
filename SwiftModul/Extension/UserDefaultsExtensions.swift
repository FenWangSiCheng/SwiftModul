//
//  UserDefaultsExtensions.swift
//  SwifterSwift
//
//  Created by wangsicheng on 9/5/18.
//  Copyright © 2018 SwifterSwift
//

import Foundation

public struct PreferenceName<Type>: RawRepresentable {
    public typealias RawValue = String
    
    public var rawValue: String
    
    public init?(rawValue: PreferenceName.RawValue) {
        self.rawValue = rawValue
    }
}

public extension UserDefaults {
    
    subscript(key: PreferenceName<Bool>) -> Bool {
        set {
            set(newValue, forKey: key.rawValue)
        }
        get {
            return bool(forKey: key.rawValue)
        }
    }
    
    subscript(key: PreferenceName<String>) -> String? {
        set {
            set(newValue, forKey: key.rawValue)
        }
        get {
            return string(forKey: key.rawValue)
        }
    }
    
    subscript(key: PreferenceName<Int>) -> Int {
        set {
            set(newValue, forKey: key.rawValue)
        }
        get {
            return integer(forKey: key.rawValue)
        }
    }
    
    subscript(key: PreferenceName<Any>) -> Any? {
        set {
            set(newValue, forKey: key.rawValue)
        }
        get {
            return value(forKey: key.rawValue)
        }
    }
    
    func object<T: Codable>(_ type: T.Type, with key: PreferenceName<T>, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key.rawValue) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: PreferenceName<T>, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key.rawValue)
    }
   
}

