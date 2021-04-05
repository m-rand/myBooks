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
    private var cancellationToken: AnyCancellable?
    @Published var subjectBooks: [Book] = []
}


extension SubjectViewModel {
    
    func searchSubject(query: String) {
        let q = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        cancellationToken = BookDB.requestSubject(path: .subjects, query: q)
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

