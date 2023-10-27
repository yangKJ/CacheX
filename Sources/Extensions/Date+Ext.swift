//
//  Date+Ext.swift
//  CacheX
//
//  Created by Condy on 2023/10/26.
//

import Foundation

extension CacheXWrapper where Base == Data {
    
    /// Returns a string initialized by converting given data into unicode characters using a given encoding.
    /// - Parameter encoding: Unicode characters using a given encoding.
    /// - Returns: Data => string.
    public func toString(encoding: String.Encoding = .utf8) -> String? {
        String(data: base, encoding: encoding)
    }
}
