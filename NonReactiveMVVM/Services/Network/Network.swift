//
//  Network.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case Unknown
    case InvalidResponse
    
    var description: String {
        switch self {
        case .Unknown: return "An unknown error occurred"
        case .InvalidResponse: return "Received an invalid response"
        }
    }
}

protocol NetworkCancelable {
    func cancel()
}
extension URLSessionDataTask: NetworkCancelable { }

protocol Network {
    func makeRequest(request: NetworkRequest, success: @escaping ([String: AnyObject]) -> Void, failure: @escaping  (Error) -> Void) -> NetworkCancelable?
    func makeRequest(request: NetworkRequest, success: @escaping  (NSData) -> Void, failure: @escaping  (Error) -> Void) -> NetworkCancelable?
}
