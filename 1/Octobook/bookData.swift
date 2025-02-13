//
//  bookData.swift
//  Octobook
//
//  Created by Elias Zeh on 12.02.25.
//

import Foundation

class BookData: ObservableObject {
    @Published var books: [Book] = []

    init() {
        loadBooks()
    }

    func loadBooks() {
        guard let url = Bundle.main.url(forResource: "bookData", withExtension: "json") else {
            print("❌ bookData.json not found!")
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load bookData.json")
            return
        }

        let decoder = JSONDecoder()

        do {
            let decodedBooks = try decoder.decode([Book].self, from: data)
            DispatchQueue.main.async {
                self.books = decodedBooks
            }
        } catch {
            print("❌ Failed to decode JSON: \(error)")
        }
    }
}
