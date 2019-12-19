//
//  NetworkClient.swift
//  UMLTask
//
//  Created by Ali Kabel on 19.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import Foundation

struct NetworkClient {
    func performNetworkingTask<T: Codable>(endPoint: GithubAPI,
                                           type: T.Type,
                                           success: ((_ response: T) -> Void)?,
                                           failure: ((Error) -> Void)?) {
        guard let baseURL = endPoint.baseURL else { return }
        let urlString = baseURL.appendingPathComponent(endPoint.path).absoluteString.removingPercentEncoding
        guard let fullURL = URL(string: urlString ?? "") else { return }
        let urlSession = URLSession.shared.dataTask(with: fullURL) {data, response, error in
            if let error = error {
                failure?(error)
            }
            guard let data = data else { return }
            let response = Response(data: data)
            guard let result = response.decode(type) else { return }
            success?(result)
        }
        urlSession.resume()
    }
}

