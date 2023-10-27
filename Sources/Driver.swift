//
//  Driver.swift
//  CacheX
//
//  Created by Condy on 2023/3/23.
//

import Foundation

public final class Driver {
    
    public lazy var disk: Disk = Disk()
    public lazy var memory: Memory = Memory()
    
    public let backgroundQueue: DispatchQueue
    
    /// Initialize the object.
    /// - Parameter queue: The default thread is the background thread.
    public init(queue: DispatchQueue? = nil) {
        self.backgroundQueue = queue ?? {
            /// Create a background thread.
            DispatchQueue(label: "com.condy.CacheX.cached.queue", attributes: [.concurrent])
        }()
    }
}

extension Driver {
    /// Read disk data or memory data.
    public func read(key: String, options: CachedOptions) -> Data? {
        if options.contains(.memory), let data = memory.read(key: key) {
            return data
        }
        if options.contains(.disk), let data = disk.read(key: key) {
            return data
        }
        return nil
    }
    
    /// Write data asynchronously to disk and memory.
    public func write(key: String, value: Data, options: CachedOptions) {
        backgroundQueue.async {
            if options.contains(.disk) {
                self.disk.store(key: key, value: value)
            }
            if options.contains(.memory) {
                self.memory.store(key: key, value: value)
            }
        }
    }
    
    /// Remove the specified data.
    public func removed(forKey key: String, options: CachedOptions) {
        if options.contains(.disk) {
            self.disk.removeCache(key: key)
        }
        if options.contains(.memory) {
            self.memory.removeCache(key: key)
        }
    }
    
    /// Remove disk cache and memory cache.
    public func removedDiskAndMemoryCached(completion: SuccessComplete? = nil) {
        backgroundQueue.async {
            self.disk.removedCached { isSuccess in
                DispatchQueue.main.async { completion?(isSuccess) }
            }
            self.memory.removedAllCached()
        }
    }
}
