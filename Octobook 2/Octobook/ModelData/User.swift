//
//  Book.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import Foundation
import SwiftUI


struct User: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var booksRead: String
    var currentlyReading: String
    var profileImage: String
    var backgroundImage: String
    var favoriteBookIds: Set<String>
    
    
    var image: Image {
        if let uiImage = loadImageFromDocuments(named: backgroundImage) {
            return Image(uiImage: uiImage)
        }
        return Image(backgroundImage)
    }
    
    init(id: String, name: String, booksRead: String, currentlyReading: String, profileImage: String, backgroundImage: String) {
        self.id = id
        self.name = name
        self.booksRead = booksRead
        self.currentlyReading = currentlyReading
        self.profileImage = profileImage
        self.backgroundImage = backgroundImage
        self.favoriteBookIds = []
    }
    
    private func loadImageFromDocuments(named: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("\(named).jpg")
        return UIImage(contentsOfFile: url.path)
    }
}
