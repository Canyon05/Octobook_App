//
//  profileView.swift
//  Octobook
//
//  Created by Elias Zeh on 14.02.25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userData: UserData
    @ObservedObject var bookData: BookData
    @ObservedObject var journalData: JournalData
    var user: User
    
    enum ImagePickerType {
        case profile
        case background
    }
    
    @State private var showingImagePicker = false
    @State private var imagePickerType: ImagePickerType = .profile
    @State private var selectedImage: UIImage?
    
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
            
            HStack{
                Text("Journal")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(3.0)
            .padding(.leading, 5.0)
            Divider()
            VStack{
                JournalView(userData: userData, journalData: journalData, user: userData.users[0], blog: journalData.blogs[0])
            }
            
        }
    }
    
    private func saveImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            print("Error: Could not convert image to data")
            return
        }
        
        let filename = imagePickerType == .profile ? 
            "\(user.id)_profile.jpg" : "\(user.id)_background.jpg"
        
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            updateUserImage(type: imagePickerType)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
    
    private func updateUserImage(type: ImagePickerType) {
        guard let index = userData.users.firstIndex(where: { $0.id == user.id }) else { return }
        var updatedUser = user
        
        switch type {
        case .profile:
            updatedUser.profileImage = "\(user.id)_profile"
        case .background:
            updatedUser.backgroundImage = "\(user.id)_background"
        }
        
        userData.users[index] = updatedUser
        userData.saveUsers()
    }
}

#Preview {
    let userData = UserData()
    return ProfileView(userData: userData, bookData: BookData(), journalData: JournalData(), user: userData.users[0])
}
