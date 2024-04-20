//
//  URL+imagePath.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import Foundation

extension URL {
    static func imagePath(_ path: String) -> URL? {
        return URL(string: "http://127.0.0.1:8000\(path)")
    }
}
