//
//  BookRow.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI


struct BookRow: View {
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
            }

            Spacer()

            if book.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let books = ModelData().books
    return Group {
        BookRow(book: books[0])
        BookRow(book: books[1])
    }
}
