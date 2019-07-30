//
//  CacheTool.swift
//  LiveProduct
//
//  Created by wangsicheng on 2018/1/22.
//  Copyright © 2018年 kaito. All rights reserved.
//

import UIKit
import Cache

struct CacheToolFactory {
    static let dataCacheTool = CacheTool<Data>()
}

public class CacheTool<T: Codable>: NSObject {
    
    public func getShareInstance<T>() -> CacheTool<T> {
       return CacheTool<T>()
    }

    private var storage: Storage<T>?
    
    override init() {
        let diskConfig = DiskConfig(name: "KaitoCache")
        let memoryConfig = MemoryConfig(expiry: .never)
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: T.self))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// remove all data
    public func removeAllCache(completion: @escaping (Bool)->()) {
        storage?.async.removeAll(completion: { result in
            DispatchQueue.main.async {
                switch result {
                    case .value: completion(true)
                    case .error: completion(false)
                }
            }
        })
    }
    /// remove data for key
    public func removeObjectCache(_ cacheKey: String, completion: @escaping (Bool)->()) {
        storage?.async.removeObject(forKey: cacheKey, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    /// async get data
    public func object(forKey key: String, completion: @escaping (Cache.Result<T>) -> Void) {
        storage?.async.object(forKey: key, completion: completion)
    }
    
    /// get data
    public func objectSync(forKey key: String) -> T? {
        do {
            return try storage?.object(forKey: key) ?? nil
        } catch {
            return nil
        }
    }
    /// async set data
    public func setObject(_ object: T, forKey: String) {
        storage?.async.setObject(object, forKey: forKey, completion: {(_) in
        })
    }
 
}



