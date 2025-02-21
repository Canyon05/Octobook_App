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
    var favorites: String
    var currentlyReading: String
    var rating: Int // 0-5 stars
    var isRead: Bool
    
    private var backgroundImage: String
    var image: Image {
        if let uiImage = loadImageFromDocuments(named: backgroundImage) {
            return Image(uiImage: uiImage)
        }
        return Image(backgroundImage)
    }
    
    init(id: String, name: String, booksRead: String, favorites: String,
         currentlyReading: String, rating: Int, isRead: Bool, backgroundImage: String) {
        self.id = id
        self.name = name
        self.booksRead = booksRead
        self.favorites = favorites
        self.currentlyReading = currentlyReading
        self.rating = rating
        self.isRead = isRead
        self.backgroundImage = backgroundImage
    }
    
    private func loadImageFromDocuments(named: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("\(named).jpg")
        return UIImage(contentsOfFile: url.path)
    }
}
