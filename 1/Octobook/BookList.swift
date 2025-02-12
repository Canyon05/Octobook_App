//
//  BookList.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI

struct BookList: View {
    @StateObject var bookData = BookData() // Dynamic book data

    var body: some View {
        NavigationView {
            List(bookData.books) {  book in
                BookRow(book: book)
            }
            .navigationTitle("Books")
        }
    }
}
#Preview {
    BookList()
}
