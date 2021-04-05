//
//  DiscoverView.swift
//  myBooks
//
//  Created by Marcel Baláš on 26.01.2021.
//

import SwiftUI

struct DiscoverView: View {

    @ObservedObject var viewModel: SubjectViewModel
    @State var userInput = ""

    
    private func search(text: String) {
        self.viewModel.searchSubject(query: text)
    }
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $userInput, placeholder: "Subject to search...", action: {
                    search(text: userInput)
                })
            
                ForEach(viewModel.subjectBooks) { book in
                    HStack {
                        NetworkImage(url: createUrlfromId(coverId: book.coverId))
                            .frame(width: 100, height: 100, alignment: .center)
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.authorName)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Search subject")
        }
    }
}


struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        let model = SubjectViewModel()
        DiscoverView(viewModel: model)
            .onAppear(perform: {
                model.subjectBooks = [Book]()
                let b: Book = Book(title: "The Fountainhead",authorName: "Ayn Rand", coverId: 1237365)
                model.subjectBooks.append(b)
            })
    }
}
