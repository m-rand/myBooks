//
//  SearchRow.swift
//  myBooks
//
//  Created by Marcel Baláš on 28.01.2021.
//

import SwiftUI

struct SearchRow: View {
    var authorName: String
    var books: [Book]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(authorName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(books) { book in
                        NetworkImage(url: createUrlfromId(coverId: book.coverId))
                            .frame(width: 120, height: 120, alignment: .center)
                    }
                }
            }
        }
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        let a = [Book]()
        SearchRow(authorName: "Victor Hugo", books: a)
    }
}
