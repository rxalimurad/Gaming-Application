//
//  URLRequestConvertibleType.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import Foundation

protocol URLRequestConvertibleType {
    func urlRequest() throws -> URLRequest
}
enum HTTPMethod {
    case get
    case post(body: Data?)

    var toString: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

enum ServiceNames: String {
    case game = "/api/games"
}
struct Endpoint {
    private let scheme: String = "https"
    private let host: String = URLs.baseURL
    private let urlPostfix: String?
    private let method: HTTPMethod
    private let queryItems: [String: Any?]?
    private let path: [String]?

    fileprivate var url: URL? {
        var components = URLComponents()
        var cPath = ServiceNames.game.rawValue + (path?.compactMap { "/\($0)" }.joined() ?? "")
        if urlPostfix != nil {
            cPath.append("/\((urlPostfix ?? ""))")
        }
        components.scheme = scheme
        components.host = host
        components.path = cPath
        components.queryItems = queryItems?.compactMap { URLQueryItem(name: $0.key, value: $0.value as? String) }
        return components.url
    }

    init(urlPostfix: String?,
         method: HTTPMethod,
         path: [String]? = nil,
         queryItems: [String: String?]? = nil) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.urlPostfix = urlPostfix
    }

}

extension Endpoint: URLRequestConvertibleType {
    func urlRequest() throws -> URLRequest {
        guard let url = url else { throw NetworkRequestError.serverError(error: "Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = method.toString
        if case let HTTPMethod.post(body) = method {
            request.httpBody = body
        }
        return request
    }
}
