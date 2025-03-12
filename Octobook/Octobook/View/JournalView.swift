//
//  profileView.swift
//  Octobook
//
//  Created by Elias Zeh on 14.02.25.
//

import SwiftUI

struct JournalView: View {
    @StateObject private var bookData = BookData()
    @ObservedObject var userData: UserData
    @ObservedObject var journalData: JournalData
    let user: User
    let blog: Blog
    
    @State private var showingAddBlog = false
    @State private var selectedBookId: String? = nil
    @State private var searchText = ""
    @State private var isEditing = false
    
    private var selectedBook: Book? {
        if let id = selectedBookId {
            return bookData.books.first { $0.id == id }
        }
        return bookData.books.first { $0.id == user.currentlyReading }
    }
    
    private var filteredBlogs: [Blog] {
        journalData.blogs
            .filter { blog in
                if let selectedId = selectedBookId {
                    return blog.bookId == selectedId
                }
                return blog.bookId == user.currentlyReading
            }
            .filter { searchText.isEmpty || $0.blogtext.localizedCaseInsensitiveContains(searchText) }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Selected Book Row
            if let book = selectedBook {
                    BookRow(bookData: bookData, book: book)
                    .padding(.horizontal, 25.0)
            }
            
            // Book Selection Menu and Edit Button
            HStack {
                Menu {
                    Button("Currently Reading") {
                        selectedBookId = nil
                    }
                    
                    ForEach(bookData.books) { book in
                        Button(action: {
                            selectedBookId = book.id
                        }) {
                            HStack {
                                Text(book.name)
                                if selectedBookId == book.id {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "book")
                        Text(selectedBook?.name ?? "Currently Reading")
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .lineLimit(1)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.white))
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                
                Spacer()
                
                Button(action: {
                    showingAddBlog = true
                }) {
                    Text("Add")
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 2)
                
                
                // Edit button
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 2)
            }
            .padding(.horizontal, 25.0)
            
            
            
            
            // Search and Blog List
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                    
                    if filteredBlogs.isEmpty {
                        EmptyStateView()
                    } else {
                        ForEach(filteredBlogs) { blog in
                            BlogPostRow(
                                blog: blog,
                                journalData: journalData,
                                isEditing: isEditing
                            )
                        }
                    }
                }
            }
            .padding(.horizontal, 5.0)
            .padding(.vertical, 10.0)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding([.leading, .bottom, .trailing], 15.0)
            
        }
        .navigationTitle("Journal")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddBlog = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddBlog) {
            AddBlogPost(
                journalData: journalData,
                initialBookId: selectedBookId ?? user.currentlyReading
            )
        }
    }
}

#Preview {
    let userData = UserData()
    let journalData = JournalData()
    JournalView(userData: userData, journalData: journalData, user: userData.users[0], blog: journalData.blogs[0])
}

// MARK: - Subviews
private struct AddBlogButton: View {
    @Binding var showingAddBlog: Bool
    let journalData: JournalData
    let BookId: String
    
    var body: some View {
        Button(action: { showingAddBlog = true }) {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $showingAddBlog) {
            AddBlogPost(journalData: journalData, initialBookId: BookId)
        }
    }
}

private struct CurrentBookSection: View {
    let book: Book
    let bookData: BookData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Currently Reading")
                .font(.headline)
            
            BookRow(bookData: bookData, book: book)
        }
        .padding(.horizontal, 25)
    }
}

private struct ControlsSection: View {
    @Binding var selectedBookId: String?
    @Binding var showingAddBlog: Bool
    let books: [Book]
    let journalData: JournalData
    
    var body: some View {
        HStack {
            // Book Selection Menu
            Menu {
                Button("Currently Reading") {
                    selectedBookId = nil
                }
                
                ForEach(books) { book in
                    Button(action: {
                        selectedBookId = book.id
                    }) {
                        HStack {
                            Text(book.name)
                            if selectedBookId == book.id {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "book")
                    Text(selectedBookId.flatMap { id in
                        books.first { $0.id == id }?.name
                    } ?? "Currently Reading")
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .foregroundColor(.primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.white))
                .cornerRadius(8)
            }
            
            Spacer()
            
            AddBlogButton(showingAddBlog: $showingAddBlog, journalData: journalData, BookId: selectedBookId ?? "0")
        }
        .padding(.horizontal)
    }
}

private struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "doc.text")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            
            Text("No Blog Posts available")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.horizontal, 25)
    }
}

private struct BookSelectionSection: View {
    @Binding var selectedBookId: String?
    let currentlyReading: String
    let books: [Book]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                BookFilterButton(
                    title: "Currently Reading",
                    isSelected: selectedBookId == nil,
                    action: { selectedBookId = nil }
                )
                
                ForEach(books) { book in
                    BookFilterButton(
                        title: book.name,
                        isSelected: selectedBookId == book.id,
                        action: { selectedBookId = book.id }
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
}

private struct BookFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .lineLimit(1)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .shadow(radius: 5)
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
                
        }
    }
}

private struct BookFilterMenu: View {
    @Binding var selectedBookId: String?
    let books: [Book]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                FilterButton(
                    title: "Currently Reading",
                    isSelected: selectedBookId == nil,
                    action: { selectedBookId = nil }
                )
                
                ForEach(books) { book in
                    FilterButton(
                        title: book.name,
                        isSelected: selectedBookId == book.id,
                        action: { selectedBookId = book.id }
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
}

private struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .lineLimit(1)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color.secondary.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
                .animation(.easeInOut, value: isSelected)
        }
    }
}

private struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search posts...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

