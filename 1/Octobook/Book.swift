//
//  Book.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import Foundation
import SwiftUICore

struct Book: Identifiable, Codable {
    var id: Int
    var name: String
    var category: String
    var author: String
    var description: String
    var isFeatured: Bool
    var isFavorite: Bool
    
    var cover: String
    var image: Image {
        Image(cover)
    }
}
