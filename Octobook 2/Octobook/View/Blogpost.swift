//
//  Blogpost.swift
//  Octobook
//
//  Created by Elias Zeh on 21.02.25.
//

import SwiftUI

struct BlogPost: View {
    @ObservedObject var journalData: JournalData
    var blog: Blog
    @StateObject private var bookData = BookData()
    
    private var associatedBook: Book? {
        bookData.books.first { $0.id == blog.bookId }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Content ScrollView
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Book title and pages read
                    HStack {
                        if let book = associatedBook {
                            Text(book.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "book")
                                .foregroundColor(.secondary)
                            Text("\(blog.pages) pages")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Blog content with preview
                    ScrollView{
                        Text(blog.blogtext)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.vertical, 8)
                    }
                    // Date and "Read more" link
                    HStack {
                        Text(blog.date)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}

#Preview {
    let journalData = JournalData()
    BlogPost(journalData: journalData, blog: journalData.blogs[0])
        .preferredColorScheme(.light)
}
