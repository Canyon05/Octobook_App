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
            
            HStack {
                book.image  // Dynamically displaying the image
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.all, 10.0)
                
                VStack {
                    Text(book.name)  // Dynamic book title
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    HStack {
                        FavoriteButton(isSet: $modelData.books[bookIndex].isFavorite)
                            .frame(width: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                        ReadButton(isSet: $modelData.books[bookIndex].read)
                            .frame(width: 50.0)
                    }
                }
                .padding([.top, .bottom, .trailing], 10.0)
            }
            .frame(height: 165.0)
            .background(Color(white: 1, opacity: 0.9))
            .cornerRadius(8)
            .padding(.vertical ,10)
            
            HStack {
                Text("Author: \(book.author)")  // Dynamic author
                    .multilineTextAlignment(.leading)
                Text("Genre: \(book.category)")  // Dynamic genre
                    .multilineTextAlignment(.trailing)
            }
            
            Text("Description:")
                .frame(alignment: .leading)
                .padding(.top, 25.0)
            
            Text(book.description)  // Dynamic description
                .padding(.horizontal, 25.0)
        }
        .background(Color(white: 1, opacity: 0.8))
        .background {
            Image("2OctoArm")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
        }
        .padding(.vertical, 10.0)
        .navigationTitle(book.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    let modelData = ModelData()
    BookDetails(book: modelData.books[0])
    .environment(modelData)
}
