//
//  Book.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import Foundation
import SwiftUI


struct Book: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var category: String
    var author: String
    var description: String
    var isFavorite: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
