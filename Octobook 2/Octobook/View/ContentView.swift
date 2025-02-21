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
                    journalView(userData: userData, user: userData.users[0])
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
                VStack{
                    let userData = UserData()
                    profileView(userData: userData, user: userData.users[0])
                }
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
