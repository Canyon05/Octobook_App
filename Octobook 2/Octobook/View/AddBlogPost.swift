//
//  Blogpost.swift
//  Octobook
//
//  Created by Elias Zeh on 21.02.25.
//

import SwiftUI

struct addBlogPost: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var journalData: JournalData
    var blog: Blog
    
    @State private var blogText: String = ""
    @State private var userId: String = ""
    @State private var bookId: String = ""
    @State private var date = Date.now
    
    
    
    var body: some View {
        
        let currentDate = getCurrentDate()
        
        VStack{
            TextField("new blog", text: $blogText, axis: .vertical)
                .lineLimit(9, reservesSpace: true)
                .padding(25)
            Divider()
            HStack{
                Text(currentDate)
                Spacer()
                Button("Submit") {
                    addBlog()
                    dismiss()
                    
                }
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
    
    private func addBlog() {
        let newBlog = Blog(
            id: UUID().uuidString,
            userId: "0",
            bookId: "0",
            date: getCurrentDate(),
            blogtext: blogText
        )
        journalData.addBlog(newBlog)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


#Preview {
    let journalData = JournalData()
    addBlogPost(journalData: journalData, blog: journalData.blogs[0])
}
