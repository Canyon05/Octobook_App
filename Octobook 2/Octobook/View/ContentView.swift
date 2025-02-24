//
//  ContentView.swift
//  Octobook
//
//  Created by Elias Zeh on 12.02.25.
//

import SwiftUI


struct ContentView: View {
    
    
    var body: some View {
        
        VStack{
            TabView{
                VStack{
                    BookList()
                }
                .tabItem{
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
                VStack{
                    let userData = UserData()
                    profileView(userData: userData, user: userData.users[0])
                }
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                VStack{
                    let userData = UserData()
                    let journalData = JournalData()
                    JournalView(userData: userData, journalData: journalData, user: userData.users[0], blog: journalData.blogs[0])
                        .background {
                            Image("2OctoArm_White")
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                        }
                }
                .tabItem{
                    Image(systemName: "book.pages")
                    Text("Current Book")
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
