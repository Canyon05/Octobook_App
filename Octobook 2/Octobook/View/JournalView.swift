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
    
    @State private var blog: String = ""
    
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
                Text("kuwlfhuigalryibfiyprbyfibyapiebhyufaebgfuysebfmnlkewnl;NEJFNBWIHBHIL;EFBHEIAL;KIHBFEWAayubgyuaesbyugobrhsyaeu")
                    .padding([.leading, .bottom, .trailing], 19.0)
                VStack{
                    TextField("new blog", text: $blog)
                        .padding(25)
                    Spacer()
                    Divider()
                    HStack{
                        Text("Date")
                        Spacer()
                        Text("done")
                    }
                    .font(.subheadline)
                    .padding(5)
                    .padding(.horizontal, 25.0)
                }
                .frame(height: 300)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(25)
            }
            
        }
    }
}

#Preview {
    let userData = UserData()
    return journalView(userData: userData, user: userData.users[0])
}
