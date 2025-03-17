//
//  ContentView.swift
//  Octobook
//
//  Created by Elias Zeh on 12.02.25.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var userData = UserData()
    @StateObject private var bookData = BookData()
    @StateObject private var journalData = JournalData()
    
    var body: some View {
        TabView {
            BookList()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
            
            ProfileView(
                userData: userData,
                bookData: bookData,
                journalData: journalData,
                user: userData.users[0]
            )
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            JournalView(userData: userData, journalData: journalData, user: userData.users[0], blog: journalData.blogs[0])
                .background {
                    Image("2OctoArm_White")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                }
            .tabItem{
                Image(systemName: "book.pages")
                Text("Current Book")
            }
        }
    }
}

#Preview {
    ContentView()
}
