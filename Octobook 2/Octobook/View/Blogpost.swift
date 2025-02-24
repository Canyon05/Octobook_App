//
//  Blogpost.swift
//  Octobook
//
//  Created by Elias Zeh on 21.02.25.
//

import SwiftUI

struct Blogpost: View {
    @ObservedObject var journalData: JournalData
    var blog: Blog
    

    var body: some View {
        
        VStack{
            ScrollView{
                Text(blog.blogtext)
                    .lineLimit(9, reservesSpace: true)
                    .padding(25)
            }
            Divider()
            HStack{
                Text(blog.date)
                Spacer()
                Text(blog.pages) //Bookname
            }
            .font(.subheadline)
            .padding(10)
        }
        .frame(height: 300)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(25)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}


#Preview {
    let journalData = JournalData()
    Blogpost(journalData: journalData, blog: journalData.blogs[0])
}
