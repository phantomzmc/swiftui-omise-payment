//
//  BaseApiService.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import Foundation
import Combine
import SwiftyJSON

struct API {
    static let baseURL = URL(string: "http://127.0.0.1:8080")!
}

class BaseAPIService {    
    enum APIError: Error {
        case decodingError
        case networkError(Error)
        case unknownError
    }
    
//    func fetchData(url: URL) -> AnyPublisher<BaseAPIResponse, Error> {
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: BaseAPIResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
    
    func fetchData(url: URL, completed: Bool, completion: @escaping (Result<JSON, APIError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(.networkError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.unknownError))
            }
            
            do {
                completion(.success(JSON(rawValue: data)!))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    
    func postData<T: Encodable>(url: URL, payload: T, completed: Bool, completion: @escaping (Result<JSON, APIError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(payload)
            request.httpBody = requestBody
        } catch {
            return completion(.failure(.decodingError))
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(.networkError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.unknownError))
            }
            
            do {
                completion(.success(JSON(rawValue: data)!))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
