//
//  SearchView.swift
//  myBooks
//
//  Created by Marcel Baláš on 26.01.2021.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchTitleViewModel
    @State var userInput = ""
    
    private func search(text: String) {
        self.viewModel.searchTitle(query: text)
    }
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $userInput, placeholder: "Book title...", action: {
                    search(text: userInput)
                })
                ForEach(viewModel.searchTitleBooks, id: \.0) { item in
                    SearchRow(authorName: item.0, books: item.1)
                }
            }
            .navigationTitle("Search Title")
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let model = SearchTitleViewModel()
        SearchView(viewModel: model)
            .onAppear(perform: {
                model.searchTitleBooks = [(String, [Book])]()
                let b: Book = Book(title: "The Fountainhead", authorName: "Ayn Rand", coverId: 1237365)
                let item = ("Ayn Rand", [b])
                model.searchTitleBooks.append(item)
            })
    }
}
