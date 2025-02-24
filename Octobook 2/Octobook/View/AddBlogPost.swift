//
//  Blogpost.swift
//  Octobook
//
//  Created by Elias Zeh on 21.02.25.
//

import SwiftUI

struct AddBlogPost: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var journalData: JournalData
    @StateObject private var bookData = BookData()
    
    @State private var blogText: String = ""
    @State private var selectedBookId: String?
    @State private var date = Date.now
    @State private var pagesRead: String = ""
    
    private var isValidInput: Bool {
        guard let pages = Int(pagesRead),
              let book = selectedBook,
              let totalPages = book.pages else { 
            return false 
        }
        
        let currentProgress = book.currentPage ?? 0
        return !blogText.isEmpty &&
               selectedBookId != nil &&
               pages > 0 && 
               (currentProgress + pages) <= totalPages
    }
    
    private var selectedBook: Book? {
        guard let id = selectedBookId else { return nil }
        return bookData.books.first { $0.id == id }
    }
    
    private var remainingPages: Int? {
        guard let book = selectedBook,
              let totalPages = book.pages else { return nil }
        let currentProgress = book.currentPage ?? 0
        return totalPages - currentProgress
    }
    
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Book Selection and Pages Section
            VStack(alignment: .leading, spacing: 8) {
                // Book Selection Menu
                HStack {
                    Menu {
                        ForEach(bookData.books) { book in
                            Button(action: {
                                selectedBookId = book.id
                                pagesRead = "" // Reset pages when book changes
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
                            Text(selectedBook?.name ?? "Choose a book")
                                .foregroundColor(selectedBookId == nil ? .secondary : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    
                    // Pages Read Input with validation
                    if let book = selectedBook,
                       let totalPages = book.pages {
                        let currentProgress = book.currentPage ?? 0
                        let remainingPages = totalPages - currentProgress
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                TextField("Pages Read", text: $pagesRead)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 80)
                            }
                            
                            if let pages = Int(pagesRead) {
                                ProgressView(
                                    value: Double(currentProgress + pages),
                                    total: Double(totalPages)
                                )
                                Text("\(currentProgress + pages)/\(totalPages) pages")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                // Progress indicator
                if let book = selectedBook,
                   let totalPages = book.pages {
                    ProgressView(value: Double(book.currentPage ?? 0), total: Double(totalPages))
                        .padding(.horizontal)
                }
            }
            
            // Blog Text Input
            TextField("Write your thoughts...", text: $blogText, axis: .vertical)
                .lineLimit(16, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Divider()
            
            // Bottom Bar
            HStack {
                if let remaining = remainingPages {
                    Text("\(remaining) pages remaining")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button("Submit") {
                    submitBlogAndProgress()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValidInput || blogText.isEmpty)
            }
            .padding()
        }
        .frame(height: 600)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
        .padding(25)
    }
    
    private func submitBlogAndProgress() {
        guard let pages = Int(pagesRead),
              let book = selectedBook else {
            return
        }
        
        // Create and add the blog post
        let newBlog = Blog(
            id: UUID().uuidString,
            userId: "0",
            bookId: book.id,
            date: currentDate,
            pages: pagesRead,
            blogtext: blogText
        )
        journalData.addBlog(newBlog)
        
        // Update the book's progress
        let currentProgress = book.currentPage ?? 0
        let newProgress = currentProgress + pages
        bookData.updateProgress(for: book, to: newProgress)
    }
}

#Preview {
    let journalData = JournalData()
    AddBlogPost(journalData: journalData)
}
