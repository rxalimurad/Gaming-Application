//
//  APIClient.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import Foundation

protocol APIClientType {
    func request<T:Decodable>(endPoint: URLRequestConvertibleType, completion: @escaping((NetworkRequestError?, T?) -> Void))
}

final class APIClient: APIClientType {
    
    func request<T:Decodable>(endPoint: URLRequestConvertibleType, completion: @escaping((NetworkRequestError?, T?) -> Void)) {
        let urlRequest = (try? endPoint.urlRequest())!
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                if (error as NSError).code == -1009 {
                    completion(NetworkRequestError.notConnected, nil)
                } else {
                completion(NetworkRequestError.serverError(error: error.localizedDescription), nil)
                }
                return
            }
            guard let data = data else {
                completion(NetworkRequestError.emptyData, nil)
                return
            }
            if let respObject = try? JSONParser().parse(type: T.self, from: data) {
                completion(nil, respObject)
            } else {
                completion(NetworkRequestError.parsingError, nil)
            }
        }
        task.resume()
        
    }
    
}
