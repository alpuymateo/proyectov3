//
//  APIClient.swift
//  AFTest
//
//  Created by German Rodriguez on 7/20/21.
//

import Foundation
import Alamofire

enum APIRouteSessionPolicy {
    case privateDomain, publicDomain
}

let apiKey = "f4120e3802ceeb0a1b65b504a012e076"
let session_id = Settings.shared.sessionId
protocol APIRoute: URLRequestConvertible {
    var method: HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var sessionPolicy: APIRouteSessionPolicy { get }
}
extension APIRoute {
    var baseURL: String { "https://api.themoviedb.org/3/" }
    
    var encoding: Alamofire.ParameterEncoding {
        switch self.method {
        case .get, .delete, .patch: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }

    func encoded(path: String, params: [String:Any]) throws -> URLRequest {
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var params = params
        var url = URL(string: baseURL + encodedPath)!
            switch self.method {
            case .get, .delete, .patch:
                params["api_key"] = apiKey
                if sessionPolicy == .privateDomain {
                    params["session_id"] = session_id //SESSION ID
                }
            default:
                var urlComponents = URLComponents(string: baseURL + encodedPath)!
                urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey /* API KEY */)]
                if sessionPolicy == .privateDomain {
                    urlComponents.queryItems?.append(URLQueryItem(name: "session_id", value: session_id /* SESSION ID */))
                }
                url = try urlComponents.asURL()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        return try self.encoding.encode(urlRequest, with: params)
    }
}   
