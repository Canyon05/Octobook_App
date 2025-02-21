//
//  profileView.swift
//  Octobook
//
//  Created by Elias Zeh on 14.02.25.
//

import SwiftUI

struct profileView: View {
    @ObservedObject var userData: UserData
    var user: User
    
    var body: some View {
        ScrollView {
            let bookData = BookData()
            Image("CallMeByYourName_BookCover")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(height: 280)
                .mask(LinearGradient(gradient: Gradient(colors: [ .black, .black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                .offset(y: -65)

            CircleImage(image: Image("OctoSmall"))
                .offset(y: -140)
                .padding(.bottom, -150)
                .frame(width: 150.0)
            HStack {
                Text("@" + user.name)
                Spacer()
                Text("Books read: " + user.booksRead)
            }
            .padding(3.0)
            .padding(.horizontal, 15.0)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            Divider()
            
            HStack{
                BookDetailsSmall(bookData: bookData, book: bookData.books[0])
                    .padding([.top, .leading, .trailing], 12)
                BookDetailsSmall(bookData: bookData, book: bookData.books[1])
                    .padding([.top, .leading, .trailing], 12)
                BookDetailsSmall(bookData: bookData, book: bookData.books[2])
                    .padding([.top, .leading, .trailing], 12)
            }
            
            Spacer()
            
            HStack {
                Text("Currently reading :")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(3.0)
            .padding(.leading, 5.0)
            Divider()
            
            ZStack{
                BookRow(bookData: bookData, book: bookData.books[0])
                    .padding(.horizontal, 25.0)
            }
            .frame(height: 100.0)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 19.0)
            .padding(.vertical, 10)
            .shadow(radius: 5)
            
            HStack{
                Text("Journal")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(3.0)
            .padding(.leading, 5.0)
            Divider()
            let journalData = JournalData()
            VStack{
                journalView(userData: userData, user: user, journalData: journalData, blog: journalData.blogs[0])
            }
            
        }
    }
}

#Preview {
    let userData = UserData()
    return profileView(userData: userData, user: userData.users[0])
}
