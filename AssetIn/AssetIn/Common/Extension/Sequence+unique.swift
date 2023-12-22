//
//  Sequence+unique.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/12/23.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
