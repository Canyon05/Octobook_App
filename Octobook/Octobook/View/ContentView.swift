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
                    BookList()
                        .background(Color.black)
                }
                .tabItem{
                    Image(systemName: "book.pages")
                    Text("Current Book")
                }
                VStack{
                    profileView()
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
