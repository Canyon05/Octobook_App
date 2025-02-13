//
//  BookList.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI

struct BookList: View {
    @StateObject var bookData = BookData()
    @State private var minimumRating = 0
    @State private var showFavoritesOnly = false
    @State private var selectedCategory: String? = nil
    @State private var readFilter: ReadFilter = .all
    @State private var showingAddBook = false
    
    enum ReadFilter {
        case all, read, unread
        
        var label: String {
            switch self {
            case .all: return "All Books"
            case .read: return "Read"
            case .unread: return "Unread"
            }
        }
    }
    
    var categories: [String] {
        Array(Set(bookData.books.map { $0.category })).sorted()
    }

    var filteredBooks: [Book] {
        bookData.books.filter { book in
            let matchesRating = book.rating >= minimumRating
            let matchesCategory = selectedCategory == nil || book.category == selectedCategory
            let matchesReadStatus = readFilter == .all ||
                (readFilter == .read && book.isRead) ||
                (readFilter == .unread && !book.isRead)
            
            return matchesRating && matchesCategory && matchesReadStatus
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    Menu {
                        ForEach(0...5, id: \.self) { rating in
                            Button(rating == 0 ? "Show All" : "★\(rating) or higher") {
                                minimumRating = rating
                            }
                        }
                    } label: {
                        Label(
                            minimumRating == 0 ? "All Ratings" : "★\(minimumRating) or higher",
                            systemImage: "star.fill"
                        )
                    }
                    
                    Menu {
                        Button("All Categories") {
                            selectedCategory = nil
                        }
                        ForEach(categories, id: \.self) { category in
                            Button(category) {
                                selectedCategory = category
                            }
                        }
                    } label: {
                        Label(
                            selectedCategory ?? "All Categories",
                            systemImage: "folder"
                        )
                    }
                    
                    Menu {
                        ForEach([ReadFilter.all, .read, .unread], id: \.self) { filter in
                            Button(filter.label) {
                                readFilter = filter
                            }
                        }
                    } label: {
                        Label(
                            readFilter.label,
                            systemImage: readFilter == .read ? "book.closed.fill" : "book.closed"
                        )
                    }
                } header: {
                    Text("Filters")
                }
                
                Section {
                    ForEach(filteredBooks) { book in
                        NavigationLink(destination: BookDetails(bookData: bookData, book: book)) {
                            BookRow(bookData: bookData, book: book)
                        }
                        .listRowBackground(Color(white: 1, opacity: 0.8))
                    }
                } header: {
                    Text("Books")
                }
            }
            .background {
                Image("OctoArm")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
            }
            .scrollContentBackground(.hidden)
            .animation(.default, value: filteredBooks)
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddBook = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView(bookData: bookData)
            }
        } detail: {
            Text("Select a Book")
        }
    }
}

#Preview {
    BookList()
}
