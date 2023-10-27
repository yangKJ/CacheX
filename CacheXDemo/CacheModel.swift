//
//  CacheModel.swift
//  CacheXDemo
//
//  Created by Condy on 2023/10/26.
//

import Foundation
import UIKit
import CacheX

struct CacheModel: Codable {
    var named: String?
    var image: UIImage?
    
    public init() { }
    
    enum CodingKeys: CodingKey {
        case imageData
        case imageScale
        case named
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let scale = try container.decode(CGFloat.self, forKey: .imageScale)
        let data = try container.decode(Data.self, forKey: .imageData)
        self.image = UIImage(data: data, scale: scale)
        self.named = try container.decode(String.self, forKey: .named)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = self.image {
            try container.encode(image.pngData(), forKey: .imageData)
            try container.encode(image.scale, forKey: .imageScale)
        }
        if let named = self.named {
            try container.encode(named, forKey: .named)
        }
    }
}
