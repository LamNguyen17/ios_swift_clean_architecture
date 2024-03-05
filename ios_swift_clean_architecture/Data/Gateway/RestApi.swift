//
//  RestApi.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    var afMethod: Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: self.rawValue)
    }
}

protocol RestApi {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    func request<T: Decodable>(returnType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    
}

extension RestApi {
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    func request<T: Decodable>(returnType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "\(Config.current.baseUrl)/\(path)"
        
        print(">>> Network Request \(method.rawValue):", url)
        
        AF.request(url,
                   method: method.afMethod,
                   headers: headers)
        .validate(statusCode: 200 ..< 300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
