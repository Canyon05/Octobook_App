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
    @State private var isEditing = false
    @State private var editedName = ""
    @State private var editedBooksRead = ""
    @State private var showingFavoriteBookPicker = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                // Background Image
                Group {
                    if let backgroundImage = loadImageFromDocuments(named: user.backgroundImage) {
                        Image(uiImage: backgroundImage)
                            .resizable()
                    } else {
                        Image("OctoArmsRight")
                            .resizable()
                    }
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 280)
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), 
                                   startPoint: .top, 
                                   endPoint: .bottom))
                .offset(y: -65)
                .onTapGesture {
                    if isEditing {
                        imagePickerType = .background
                        showingImagePicker = true
                    }
                }
                
                // Edit Button
                Button(action: {
                    if isEditing {
                        saveChanges()
                    }
                    isEditing.toggle()
                    if isEditing {
                        editedName = user.name
                        editedBooksRead = user.booksRead
                    }
                }) {
                    Text(isEditing ? "Save" : "Edit")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 2)
                }
                .padding()
            }

            // Profile Image
            Group {
                if let profileImage = loadImageFromDocuments(named: user.profileImage) {
                    Image(uiImage: profileImage)
                        .resizable()
                } else {
                    Image("OctoSmall")
                        .resizable()
                }
            }
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
            .offset(y: -140)
            .padding(.bottom, -150)
            .onTapGesture {
                if isEditing {
                    imagePickerType = .profile
                    showingImagePicker = true
                }
            }

            // User Info
            VStack(spacing: 8) {
                if isEditing {
                    TextField("Username", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Books Read", text: $editedBooksRead)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                } else {
                    HStack {
                        Text("@" + user.name)
                        Spacer()
                        Text("Books read: " + user.booksRead)
                    }
                    .padding(3.0)
                    .padding(.horizontal, 15.0)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            }
            
            Divider()
            
            // Favorite Books Section
            VStack(alignment: .leading) {
                HStack {
                    if isEditing {
                        Button("Edit") {
                            showingFavoriteBookPicker = true
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    ForEach(bookData.books.filter { user.favoriteBookIds.contains($0.id) }) { book in
                        BookDetailsSmall(bookData: bookData, book: book)
                            .padding(.all, 12)
                    }
                }
            }
            
            Spacer()
            
            HStack{
                Text("Journal")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(3.0)
            .padding(.leading, 15.0)
            
            Divider()
            
            VStack{
                JournalView(
                    userData: userData,
                    journalData: journalData,
                    user: userData.users[0],
                    blog: journalData.blogs[0]
                )
            }
            .padding(.horizontal, 10.0)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage, isPresented: $showingImagePicker) { image in
                if let image = image {
                    saveImage(image)
                }
            }
        }
        .sheet(isPresented: $showingFavoriteBookPicker) {
            FavoriteBooksPicker(bookData: bookData, userData: userData, user: user)
        }
    }
    
    
    private func loadImageFromDocuments(named: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("\(named).jpg")
        return UIImage(contentsOfFile: url.path)
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
    
    private func saveChanges() {
        guard let index = userData.users.firstIndex(where: { $0.id == user.id }) else { return }
        var updatedUser = user
        updatedUser.name = editedName
        updatedUser.booksRead = editedBooksRead
        userData.users[index] = updatedUser
        userData.saveUsers()
    }
}

#Preview {
    let userData = UserData()
    return ProfileView(userData: userData, bookData: BookData(), journalData: JournalData(), user: userData.users[0])
}
