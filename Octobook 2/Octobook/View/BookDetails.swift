//
//  BookDetails.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI


struct BookDetails: View {
    @ObservedObject var bookData: BookData
    var book: Book

    var body: some View {
        ScrollView {
            HStack {
                book.image
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.all, 10.0)
                
                VStack {
                    Text(book.name)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    HStack {
                        StarRating(
                            rating: book.rating,
                            size: 24
                        ) { newRating in
                            bookData.updateRating(for: book, to: newRating)
                        }
                        
                        Button(action: {
                            bookData.toggleReadStatus(for: book)
                        }) {
                            Image(systemName: book.isRead ? "book.closed.fill" : "book.closed")
                                .foregroundStyle(book.isRead ? .blue : .gray)
                        }
                        .frame(width: 50.0)
                    }
                    VStack {
                        if !book.progress.isEmpty && !book.pages.isEmpty {
                            let pagesInt = Int(book.pages) ?? 0
                            if pagesInt > 0 {
                                let progressInt = Int(book.progress) ?? 0
                                let progressFinal = Double(progressInt) / Double(pagesInt)
                                ProgressView(value: progressFinal, total: 1.0)
                            }
                        }
                    }
                }
                .padding([.top, .bottom, .trailing], 10.0)
            }
            .frame(height: 165.0)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Author:")
                        .fontWeight(.medium)
                    Text(book.author)
                }
                
                HStack {
                    Text("Genre:")
                        .fontWeight(.medium) 
                    Text(book.category)
                }
                
                Text("Description:")
                    .fontWeight(.medium)
                    .padding(.top, 16)
                
                Text(book.description)
                    .padding(.horizontal, 8)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background {
            Image("2OctoArm_White")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
        }
        .padding(.vertical, 10.0)
        .navigationTitle(book.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    let bookData = BookData()
    return BookDetails(bookData: bookData, book: bookData.books[0])
}
