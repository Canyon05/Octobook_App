//
//  profileView.swift
//  Octobook
//
//  Created by Elias Zeh on 14.02.25.
//

import SwiftUI

struct journalView: View {
    @ObservedObject var userData: UserData
    var user: User
    @ObservedObject var journalData: JournalData
    var blog: Blog
    
    var filteredBlogs: [Blog] {
        journalData.blogs.filter { blog in
            let matchesBook = blog.bookId == user.currentlyReading
            
            return matchesBook
        }
    }
    
    var body: some View {
        HStack {
            CircleImage(image: Image("OctoSmall"))
                .frame(width: 50.0)
            Text("@" + user.name)
                .offset(y: 13)
            Spacer()
            Text("Books read: " + user.booksRead)
                .offset(y: 13)
        }
        .padding(.leading, 20.0)
        .padding(.trailing, 13.0)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        
        ScrollView {
            let bookData = BookData()
            
            Divider()
            
            VStack{
                BookRow(bookData: bookData, book: bookData.books[0])
                    .padding(.horizontal, 25.0)
                Section {
                    ForEach(filteredBlogs) { blog in
                        NavigationLink(destination: Blogpost(journalData: journalData, blog: blog)) {
                            Blogpost(journalData: journalData, blog: blog)
                        }
                    }
                } header: {
                    Text("Blog Posts :")
                }
            }
            
        }
    }
}

#Preview {
    let userData = UserData()
    let journalData = JournalData()
    return journalView(userData: userData, user: userData.users[0], journalData: journalData, blog: journalData.blogs[0])
}
