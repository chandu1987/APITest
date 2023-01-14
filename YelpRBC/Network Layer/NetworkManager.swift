//
//  NetworkManager.swift
//  YelpRBC
//
//  Created by Chandra Sekhar Ravi on 10/01/23.
//

import UIKit

enum NetworkError : Error {
    case networkError
    case parsingError
}

//Add custom descriptions to errors
extension NetworkError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network Error"
        case .parsingError:
            return "Parsing Error"
        }
    }
}


class NetworkManager  {
    
    private let urlSession: URLSession
    
    //Dependency injection incase we want to mock test the network layer.takes the default url session if nothing is passed.
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    
    
   @discardableResult func call<EndpointType>(for endpoint: EndpointType, completion: @escaping (Result<EndpointType.DataType, Error>) -> Void) -> URLSessionDataTask? where EndpointType : Endpoint {
        var request = endpoint.makeRequest(baseURL: URL(string: Constants.Urls.kBaseUrl)!)
        request.setValue(Constants.APIKeys.kYelpAPIKey, forHTTPHeaderField: "Authorization")
        
        let task = urlSession.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if urlResponse == nil{
                fatalError()
            }
            
            // Check response code.
            guard let httpResponse = urlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(Result.failure(NetworkError.networkError))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(NetworkError.parsingError))
                return
            }
            
            let result = Result {
                try endpoint.decoder.decode(EndpointType.DataType.self, from: data)
            }
            completion(result)
        }
        task.resume()
        return task
    }
    
}

