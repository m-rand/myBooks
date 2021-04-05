//
//  BookBAPIClient.swift
//  myBooks
//
//  Created by Marcel Baláš on 26.01.2021.
//

import Foundation
import Combine


struct BookDB {
    static let apiClient = APIClient()
    static let baseUrlString = "https://openlibrary.org"
}

enum APIPath: String {
    case subjects = "/subjects/"
    case searchTitle = "/search.json?title="
}

extension BookDB {
    
    static func requestSubject(path: APIPath, query: String) -> AnyPublisher<SubjectResponse, Error> {
        
        let finalUrlString = baseUrlString + path.rawValue + query + ".json"
        guard let finalUrl = URL(string: finalUrlString) else { fatalError("Couldn't create URL") }
        let request = URLRequest(url: finalUrl, timeoutInterval: 5)
        print(request)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
      
    static func requestSearch(path: APIPath, query: String) -> AnyPublisher<SearchTitleResponse, Error> {
        
        let finalUrlString = baseUrlString + path.rawValue + query
        guard let finalUrl = URL(string: finalUrlString) else { fatalError("Couldn't create URL") }
        let request = URLRequest(url: finalUrl)
        print(request)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

}
