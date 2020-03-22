//
//  SequenceType+Extensions.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

func random(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max + 1)) + UInt32(min))
}

extension Collection where Self.Index == Int {
    func randomElement() -> Self.Iterator.Element {
        let index = random(min: 0, max: self.count - 1)
        return self[index]
    }
    subscript(safe safe: Self.Index) -> Iterator.Element? {
        guard self.indices.contains(safe) else { return nil }
        return self[safe]
    }
}
