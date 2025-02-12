//
//  BookDetails.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import SwiftUI

struct BookDetails: View {
    
    var body: some View {
       Divider()
            HStack {
                Image("CallMeByYourName_BookCover")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0)
                    .offset(y : -25)
                
                
                VStack {
                    Text("Call me by your Name")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    HStack{
                        Text("stars")
                            .font(.title)
                            .multilineTextAlignment(.leading)
                        Text("read")
                            
                    }
                    
                    
                }
                .frame(height: 125.0)
            }
            
            HStack() {
                Text("Author : adrenhdka ajkd")
                    .multilineTextAlignment(.leading)
                Text("genre : Roman")
                    .multilineTextAlignment(.trailing)
            }
            Text("Description :")
                .multilineTextAlignment(.leading)
                .padding(.top, 25.0)
            Text("Andre Aciman's Call Me by Your Name is the story of a sudden and powerful romance that blossoms between an adolescent boy and a summer guest at his parents' cliffside mansion on the Italian Riviera. Each is unprepared for the consequences of their attraction, when, during the restless summer weeks, unrelenting currents of obsession, fascination, and desire intensify their passion and test the charged ground between them. Recklessly, the two verge toward the one thing both fear they may never truly find again: total intimacy. It is an instant classic and one of the great love stories of our time.")
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 25.0/*@END_MENU_TOKEN@*/)
            
        
    }
}

#Preview {
    BookDetails()
}
