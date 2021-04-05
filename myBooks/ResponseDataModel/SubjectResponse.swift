//
//  BookResponse.swift
//  myBooks
//
//  Created by Marcel Baláš on 26.01.2021.
//

import Foundation


struct SubjectBook: Codable, Identifiable {
    var id = UUID()
    let key, title: String
    let coverId: Int?
    let authors: [Author]

    enum CodingKeys: String, CodingKey {
        case key, title
        case coverId = "cover_id"
        case authors
    }
}

struct Author: Codable {
    let name, key: String
}


struct SubjectResponse : Codable {
    let books: [SubjectBook]
    
    enum CodingKeys: String, CodingKey {
        case books = "works"
    }
}
