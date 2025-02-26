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
    let initialBookId: String
    
    // MARK: - State
    @State private var blogText: String = ""
    @State private var selectedBookId: String?  // Make optional
    @State private var date = Date.now
    @State private var pagesRead: String = ""
    @State private var showingError = false
    @State private var errorMessage = ""
    @FocusState private var focusedField: Field?
    
    // MARK: - Focus Fields
    enum Field {
        case pages, blogText
    }
    
    init(journalData: JournalData, initialBookId: String) {
        self.journalData = journalData
        self.initialBookId = initialBookId
        _selectedBookId = State(initialValue: initialBookId)
    }
    
    // MARK: - Computed Properties
    private var isValidInput: Bool {
        guard let bookId = selectedBookId,
              let book = bookData.books.first(where: { $0.id == bookId }),
              let pages = Int(pagesRead),
              let totalPages = book.pages else { 
            return false 
        }
        
        let currentProgress = book.currentPage ?? 0
        return !blogText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
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
    
    // MARK: - View
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack{
                    bookSelectionSection
                    pagesSection
                }
                blogTextSection
                progressSection
                submitButton
                Spacer()
            }
            .padding()
            .alert("Error", isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
            .navigationTitle("New Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - View Components
    private var bookSelectionSection: some View {
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
            .lineLimit(1)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
    
    private var pagesSection: some View {
        VStack(alignment: .leading) {
            if let book = selectedBook,
               let totalPages = book.pages {
                HStack {
                    TextField("Pages", text: $pagesRead)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 80)
                        .focused($focusedField, equals: .pages)
                    
                    Text("/ \(totalPages)")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var blogTextSection: some View {
        TextField("Write your thoughts...", text: $blogText, axis: .vertical)
            .lineLimit(20, reservesSpace: true)
            .textFieldStyle(.roundedBorder)
            .focused($focusedField, equals: .blogText)
    }
    
    private var progressSection: some View {
        Group {
            if let book = selectedBook,
               let totalPages = book.pages {
                ProgressView(value: Double(book.currentPage ?? 0), total: Double(totalPages))
                    .padding(.horizontal)
            } else {
                EmptyView()
            }
        }
    }
    
    private var submitButton: some View {
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
    
    // MARK: - Actions
    private func submitBlogAndProgress() {
        guard let bookId = selectedBookId,
              let book = bookData.books.first(where: { $0.id == bookId }),
              let pages = Int(pagesRead),
              let totalPages = book.pages else {
            showError("Invalid input. Please check your entries.")
            return
        }
        
        let currentProgress = book.currentPage ?? 0
        if currentProgress + pages > totalPages {
            showError("Cannot exceed total pages for this book.")
            return
        }
        
        let trimmedText = blogText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            showError("Please write some thoughts about your reading.")
            return
        }
        
        // Create and add the blog post
        let newBlog = Blog(
            id: UUID().uuidString,
            userId: "0",
            bookId: book.id,
            date: formatDate(date),
            pages: pagesRead,
            blogtext: trimmedText
        )
        
        journalData.addBlog(newBlog)
        bookData.updateProgress(for: book, to: currentProgress + pages)
        dismiss()
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showingError = true
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    let journalData = JournalData()
    AddBlogPost(journalData: journalData, initialBookId: "1")
}
