//
//  Book.swift
//  Octobook
//
//  Created by Elias Zeh on 11.02.25.
//

import Foundation
import SwiftUI


struct Blog: Hashable, Codable, Identifiable {
    var id: String
    var userId: String
    var bookId: String
    var date: String
    var pages: String
    var blogtext: String
    
    init(id: String, userId: String, bookId: String, date: String, pages: String, blogtext: String) {
        self.id = id
        self.userId = userId
        self.bookId = bookId
        self.date = date
        self.pages = pages
        self.blogtext = blogtext
    }
}
