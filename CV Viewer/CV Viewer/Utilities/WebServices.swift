//
//  WebServices.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 07/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

enum FailureType: String {
    case invalidURL = "invalidURLMessage"
    case timeout = "timeoutMessage"
    case parseError = "parseErrorMessage"
    case resourceNotFound = "fileNotFoundMessage"
    case noConnection = "noConnectionErrorMessage"
    case unknownError = "unknownErrorMessage"
}

class WebServices: NSObject {

    static let shared = WebServices()
    
    private let urlSession = URLSession(configuration: .default)
    
    func fetchCVJSON(urlString: String, completion: @escaping ([[String: Any]]) -> Void, failure: @escaping (FailureType) -> Void) {
        guard let url = URL(string: urlString) else {
            failure(.invalidURL)
            return
        }
        
        self.urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                failure(.noConnection)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                switch response.statusCode {
                case 408:
                    failure(.timeout)
                    return
                case 404:
                    failure(.resourceNotFound)
                    return
                default:
                    failure(.unknownError)
                    return
                }
            }
            
            guard let jsonData = data else {
                failure(.unknownError)
                return
            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: Any]] {
                    completion(jsonObject)
                    return
                }
                failure(.unknownError)
                return
            } catch {
                failure(.parseError)
                return
            }
        }.resume()
    }
}
