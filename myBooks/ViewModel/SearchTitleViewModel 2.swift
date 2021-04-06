//
//  SearchViewModel.swift
//  myBooks
//
//  Created by Marcel Baláš on 28.01.2021.
//

import Foundation
import Combine


class SearchTitleViewModel: ObservableObject {    
    private var searchTitleResponse: [SearchTitleBook] = []
    private var cancellationToken: AnyCancellable?
    @Published var searchTitleBooks: [(String, [Book])] = []
}

extension SearchTitleViewModel {

    func searchTitle(query: String) {
        let q = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .replacingOccurrences(of: " ", with: "+")
        cancellationToken = BookAPIClient.requestSearch(path: .searchTitle, query: q)
            .print()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.searchTitleResponse = $0.books
                    self.searchTitleBooks = self.convertSearchTitle(searchBooks: self.searchTitleResponse).sorted(by: { $0.1.count > $1.1.count }) // sorted by number of books
            })
    }

    func convertSearchTitle(searchBooks : [SearchTitleBook]) -> [(String, [Book])] {
        let books = searchBooks.map { searchBook in
            return Book(title: searchBook.title,
                            authorName: searchBook.authorName?[0] ?? "Unknown",
                            coverId: searchBook.coverId ?? 0)
        }
        return Dictionary(grouping: books, by: \.authorName).map { $0 } // grouped by author's name
    }
}

