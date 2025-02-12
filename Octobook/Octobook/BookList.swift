//
//  BookList.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI

struct BookList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false

    var filteredbooks: [Book] {
        modelData.books.filter { book in
            (!showFavoritesOnly || book.isFavorite)
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                ForEach(filteredbooks) { book in
                    NavigationLink {
                        BookDetails(book: book)
                    } label: {
                        BookRow(book: book)
                    }
                }
                .listRowBackground(Color(white: 1, opacity: 0.8))
            }
            .background {
                Image("OctoArm")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
            }
            .scrollContentBackground(.hidden)
            .animation(.default, value: filteredbooks)
            .navigationTitle("Books")
        } detail: {
            Text("Select a Book")
        }
    }
}

#Preview {
    BookList()
        .environment(ModelData())
}
