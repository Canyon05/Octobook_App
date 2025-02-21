//
//  BookRow.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI


struct BookRow: View {
    @ObservedObject var bookData: BookData
    var book: Book

    var body: some View {
        HStack {
            book.image
                .resizable()
                .frame(width: 50, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text(book.name)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                StarRating(
                    rating: book.rating,
                    size: 12
                ) { newRating in
                    bookData.updateRating(for: book, to: newRating)
                }
                if !book.progress.isEmpty && !book.pages.isEmpty {
                    let pagesInt = Int(book.pages) ?? 0
                    if pagesInt > 0 {
                        let progressInt = Int(book.progress) ?? 0
                        let progressFinal = Double(progressInt) / Double(pagesInt)
                        ProgressView(value: progressFinal, total: 1.0)
                    }
                }
            }

            Spacer()

            ReadButton(
                isRead: Binding(
                    get: { book.isRead },
                    set: { _ in bookData.toggleReadStatus(for: book) }
                ),
                toggleRead: { bookData.toggleReadStatus(for: book) }
            )
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let bookData = BookData()
    return Group {
        if !bookData.books.isEmpty {
            BookRow(bookData: bookData, book: bookData.books[0])
            BookRow(bookData: bookData, book: bookData.books[1])
        } else {
            Text("No books available")
        }
    }
}
