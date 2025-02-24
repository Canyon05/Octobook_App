//
//  Book.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import Foundation
import SwiftUI


struct Book: Hashable, Codable, Identifiable{
    var id: String
    var name: String
    var category: String
    var author: String
    var description: String
    var rating: Int // 0-5 stars
    var isRead: Bool
    var pages: Int?
    var currentPage: Int?

    
    private var imageName: String
    var image: Image {
        if let uiImage = loadImageFromDocuments(named: imageName) {
            return Image(uiImage: uiImage)
        }
        return Image(imageName)
    }
    
    init(id: String, name: String, category: String, author: String, 
         description: String, rating: Int, isRead: Bool, pages: Int?,
         currentPage: Int?, imageName: String) {
        self.id = id
        self.name = name
        self.category = category
        self.author = author
        self.description = description
        self.rating = rating
        self.isRead = isRead
        self.pages = pages
        self.imageName = imageName
    }
    
    private func loadImageFromDocuments(named: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("\(named).jpg")
        return UIImage(contentsOfFile: url.path)
    }
}
