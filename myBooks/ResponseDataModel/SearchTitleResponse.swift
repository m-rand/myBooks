//
//  SearchTitleRequest.swift
//  myBooks
//
//  Created by Marcel Baláš on 28.01.2021.
//

import Foundation

struct SearchTitleBook: Codable {
    let coverId: Int?
    let title: String
    let authorName: [String]?
    let key: String
    let authorKey: [String]?

    enum CodingKeys: String, CodingKey {
        case coverId = "cover_i"
        case title
        case authorName = "author_name"
        case key
        case authorKey = "author_key"
    }
}


struct SearchTitleResponse : Codable {
    let books: [SearchTitleBook]
    
    enum CodingKeys: String, CodingKey {
        case books = "docs"
    }
}
