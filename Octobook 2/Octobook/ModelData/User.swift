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
    
    private var backgroundImage: String
    var image: Image {
        if let uiImage = loadImageFromDocuments(named: backgroundImage) {
            return Image(uiImage: uiImage)
        }
        return Image(backgroundImage)
    }
    
    init(id: String, name: String, booksRead: String, currentlyReading: String, backgroundImage: String) {
        self.id = id
        self.name = name
        self.booksRead = booksRead
        self.currentlyReading = currentlyReading
        self.backgroundImage = backgroundImage
    }
    
    private func loadImageFromDocuments(named: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("\(named).jpg")
        return UIImage(contentsOfFile: url.path)
    }
}
