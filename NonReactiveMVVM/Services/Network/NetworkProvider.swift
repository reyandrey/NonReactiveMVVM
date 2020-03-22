//
//  NetworkProvider.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

class NetworkProvider: Network {
    
    //MARK: - Private
    let session: URLSession
    
    //MARK: - Lifecycle
    init(session: URLSession = URLSession.shared) {
        self.session = session
        
    }
    
    //MARK: - Public
    func makeRequest(request: NetworkRequest, success: @escaping  ([String : AnyObject]) -> Void, failure: @escaping  (Error) -> Void) -> NetworkCancelable? {
        do {
            let request = try request.buildURLRequest()
            let task = self.session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let data = data else {
                    DispatchQueue.main.async { failure(error ?? NetworkError.unknown) }
                    return
                }
                
                guard
                    let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                    let json = jsonOptional as? [String: AnyObject]
                    else {
                        DispatchQueue.main.async { failure(NetworkError.invalidResponse) }
                        return
                    }
                DispatchQueue.main.async { success(json) }
            }
            task.resume()
            return task
            
        } catch let error {
            failure(error)
            return nil
        }
    }
    func makeRequest(request: NetworkRequest, success: @escaping  (NSData) -> Void, failure: @escaping  (Error) -> Void) -> NetworkCancelable? {
        do {
            let request = try request.buildURLRequest()
            let task = self.session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let data = data else {
                    DispatchQueue.main.async { failure(error ?? NetworkError.unknown) }
                    return
                }
                DispatchQueue.main.async { success(data as NSData) }
            }
            task.resume()
            return task
            
        } catch let error {
            failure(error)
            return nil
        }
    }
}
