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
    private var urlToken: AnyCancellable?
    
    private var textToken: AnyCancellable?
    @Published var searchText: String = String()
    
    @Published var searchTitleBooks: [(String, [Book])] = []
    
    init() {
        textToken = $searchText
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main) // wait 1s for further processing
            .map {
                return $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                    .folding(options: .diacriticInsensitive, locale: .current)
                    .replacingOccurrences(of: " ", with: "+")
            }
            .filter{ !$0.isEmpty } // the input string must have at least 1 character
            .compactMap{ $0 } // if not, return nil
            .removeDuplicates()
            .sink(receiveCompletion: { _ in },
                receiveValue: { input in
                self.searchTitle(query: input)
            })
    }
}

extension SearchTitleViewModel {

    func searchTitle(query: String) {
        urlToken = BookAPIClient.requestSearch(path: .searchTitle, query: query)
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

