//
//  profileView.swift
//  Octobook
//
//  Created by Elias Zeh on 14.02.25.
//

import SwiftUI

struct profileView: View {
    
    var body: some View {
        ScrollView {
            Image("ProfileBackground")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(height: 220)
                .offset(y: -60)
            CircleImage(image: Image("OctoSmall"))
                .offset(y: -140)
                .padding(.bottom, -150)
                .frame(width: 150.0)
            HStack {
                Text("Username")
                Spacer()
                Text("Books read")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            Divider()
            
            HStack{
                VStack {
                    Image("CallMeByYourName_BookCover")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.all, 10.0)
                    Text("Star Star Star")
                        .font(.caption)
                }
                .padding(.top, 12)
                VStack {
                    Image("CallMeByYourName_BookCover")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.all, 10.0)
                    Text("Star Star Star")
                        .font(.caption)
                }
                .padding(.top, 12)
                VStack {
                    Image("CallMeByYourName_BookCover")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.all, 10.0)
                    Text("Star Star Star")
                        .font(.caption)
                }
                .padding(.top, 12)
            }
            
            Spacer()
            
            HStack {
                Text("Currently reading :")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Divider()
            Text("Boockrow")
            Text("Journal")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider()
            Text("Boockrow")
        }
    }
}

#Preview {
    profileView()
}
