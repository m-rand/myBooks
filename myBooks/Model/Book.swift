//
//  Book.swift
//  myBooks
//
//  Created by Marcel Baláš on 26.01.2021.
//

import Foundation
import SwiftUI
import Combine


struct Book: Identifiable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
    var id = UUID()
    var title: String
    var authorName: String
    var coverId: Int
    var cover: Image?
}

