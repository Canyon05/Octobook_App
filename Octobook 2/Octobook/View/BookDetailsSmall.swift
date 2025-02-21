//
//  BookDetails.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI


struct BookDetailsSmall: View {
    @ObservedObject var bookData: BookData
    var book: Book

    var body: some View {
        VStack {
            book.image
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 120.0)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.92))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.all, 5.0)
                
            Text(book.name)
                .font(.caption2)
                .fontWeight(.light)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 10.0)
            
            StarRating(
                rating: book.rating,
                size: 8
            ) { newRating in
                bookData.updateRating(for: book, to: newRating)
            }
            .padding(.bottom, 5.0)
        }
        .frame(width: 100.0, height: 180.0)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
        
    }
}

#Preview {
    let bookData = BookData()
    return BookDetailsSmall(bookData: bookData, book: bookData.books[0])
}
