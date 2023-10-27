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
    @CodableImage_ var image: UIImage?
}
