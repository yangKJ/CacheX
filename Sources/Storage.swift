//
//  Storage.swift
//  CacheX
//
//  Created by Condy on 2023/3/23.
//  

import Foundation

/// Mixed storge transfer station.
public struct Storage<T: Codable> {
    
    public let driver: Driver
    
    lazy var transformer = TransformerFactory<T>.forCodable()
    
    /// Initialize the object.
    /// - Parameter queue: The default thread is the background thread.
    public init(queue: DispatchQueue? = nil) {
        self.driver = Driver(queue: queue)
    }
    
    /// Caching object.
    public mutating func storeCached(_ object: T, forKey key: String, options: CachedOptions) {
        guard let data = try? transformer.toData(object) else {
            return
        }
        write(key: key, value: data, options: options)
    }
    
    /// Read cached object.
    public mutating func fetchCached(forKey key: String, options: CachedOptions) -> T? {
        guard let data = read(key: key, options: options) else {
            return nil
        }
        return try? transformer.fromData(data)
    }
    
    /// Read disk data or memory data.
    public func read(key: String, options: CachedOptions) -> Data? {
        driver.read(key: key, options: options)
    }
    
    /// Write data asynchronously to disk and memory.
    public func write(key: String, value: Data, options: CachedOptions) {
        driver.write(key: key, value: value, options: options)
    }
    
    /// Remove the specified data.
    public func removed(forKey key: String, options: CachedOptions) {
        driver.removed(forKey: key, options: options)
    }
    
    /// Remove disk cache and memory cache.
    public func removedDiskAndMemoryCached(completion: SuccessComplete? = nil) {
        driver.removedDiskAndMemoryCached(completion: completion)
    }
}
