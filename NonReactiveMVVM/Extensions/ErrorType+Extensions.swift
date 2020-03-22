//
//  ErrorType+Extensions.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

extension Error {
    func displayString() -> String {
        self.localizedDescription
    }
}

extension Error where Self: CustomStringConvertible {
    func displayString() -> String {
        self.description
    }
}
