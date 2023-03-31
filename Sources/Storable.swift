//
//  Lemonable.swift
//  Lemons
//
//  Created by Condy on 2023/3/31.
//

import Foundation

public protocol Lemonable {
    
    /// Read disk data or memory data.
    func read(key: String) -> Data?
    
    /// Storage data asynchronously to disk and memory.
    func store(key: String, value: Data)
    
    /// Clear the cache according to key value.
    @discardableResult func removeCache(key: String) -> Bool
    
    func removedCached()
    
    /// Clear the disk cache.
    /// - Parameter completion: Complete the callback.
    func removedCached(completion: ((_ isSuccess: Bool) -> Void)?)
}

extension Lemonable {
    
    public func removedCached() {
        removedCached(completion: nil)
    }
}
