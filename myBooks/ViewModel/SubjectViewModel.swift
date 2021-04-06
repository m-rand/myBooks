//
//  SubjectsViewModel.swift
//  myBooks
//
//  Created by Marcel Baláš on 26.01.2021.
//

import Foundation
import Combine


class SubjectViewModel: ObservableObject {    
    private var subjectResponse: [SubjectBook] = []
    private var urlToken: AnyCancellable?
    
    private var textToken: AnyCancellable?
    @Published var searchText: String = String()
    
    @Published var subjectBooks: [Book] = []
    
    init() {
        textToken = $searchText
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main) // wait 1s for further processing
            .map {
                return $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                    .folding(options: .diacriticInsensitive, locale: .current)
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
            .filter{ !$0.isEmpty } // the input string must have at least 1 character
            .compactMap{ $0 } // if not, return nil
            .removeDuplicates()
            .sink { _ in
                //
            } receiveValue: { input in
                self.searchSubject(query: input)
            }
    }
}


extension SubjectViewModel {
    
    func searchSubject(query: String) {
        urlToken = BookAPIClient.requestSubject(path: .subjects, query: query)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.subjectResponse = $0.books
                    self.subjectBooks = self.convertSubject(subjectBooks: self.subjectResponse)
            })
    }
    
    func convertSubject(subjectBooks : [SubjectBook]) -> [Book] {
        return subjectBooks.map { subBook in
            return Book(title: subBook.title,
                            authorName: subBook.authors.isEmpty ? "Unknown" : subBook.authors[0].name,
                            coverId: subBook.coverId ?? 0)
        }
    }
}

