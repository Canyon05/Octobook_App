//
//  BookDetails.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI


struct BookDetails: View {
    @Environment(ModelData.self) var modelData
    var book: Book

    var bookIndex: Int {
        modelData.books.firstIndex(where: { $0.id == book.id })!
    }

    var body: some View {
        @Bindable var modelData = modelData
        ScrollView {
            Divider()
            
            HStack {
                book.image  // Dynamically displaying the image
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0)
                    .offset(y: -25)
                
                VStack(alignment: .leading) {
                    Text(book.name)  // Dynamic book title
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    HStack {
                        Text("⭐️ \(book.isFavorite ? "Favorite" : "Not Favorite")") // Dynamic favorite status
                            .font(.title)
                        FavoriteButton(isSet: $modelData.books[bookIndex].isFavorite)
                        Text("📖 Read")  // You can add more dynamic info here if needed
                    }
                }
                .frame(height: 125.0)
            }
            
            HStack {
                Text("Author: \(book.author)")  // Dynamic author
                    .multilineTextAlignment(.leading)
                Text("Genre: \(book.category)")  // Dynamic genre
                    .multilineTextAlignment(.trailing)
            }
            
            Text("Description:")
                .multilineTextAlignment(.leading)
                .padding(.top, 25.0)
            
            Text(book.description)  // Dynamic description
                .padding(.horizontal, 25.0)
        }
        .padding()
        .navigationTitle(book.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    let modelData = ModelData()
    BookDetails(book: modelData.books[0])
    .environment(modelData)
}
