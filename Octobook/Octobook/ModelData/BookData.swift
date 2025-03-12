/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
Storage for model data.
*/

import Foundation


class BookData: ObservableObject {
    @Published var books: [Book] = []

        private let fileName = "bookData.json"

        init() {
            loadBooks()
        }

        func loadBooks() {
            // First try to load from documents directory
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: url.path) {
                if let data = try? Data(contentsOf: url),
                   let decodedBooks = try? JSONDecoder().decode([Book].self, from: data) {
                    self.books = decodedBooks
                    return
                }
            }
            
            // If that fails, load from bundle
            if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil),
               let data = try? Data(contentsOf: bundleURL),
               let decodedBooks = try? JSONDecoder().decode([Book].self, from: data) {
                self.books = decodedBooks
                // Save bundle data to documents for future use
                saveBooks()
            } else {
                print("❌ Could not load books from bundle or documents directory")
            }
        }

        private func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }

        func toggleReadStatus(for book: Book) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books[index].isRead.toggle()
                saveBooks()
            }
        }
        
        func updateRating(for book: Book, to rating: Int) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books[index].rating = min(max(rating, 0), 5) // Ensure rating is between 0-5
                saveBooks()
            }
        }
        
        private func saveBooks() {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            if let data = try? JSONEncoder().encode(books) {
                try? data.write(to: url)
            }
        }

        func addBook(_ book: Book) {
            books.append(book)
            saveBooks()
        }

        func updateProgress(for book: Book, to pages: Int) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books[index].currentPage = pages
                // If the book is complete
                if let totalPages = books[index].pages, pages >= totalPages {
                    books[index].isRead = true
                }
                saveBooks()
            }
        }

        func deleteBook(_ book: Book) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books.remove(at: index)
                saveBooks()
            }
        }
}
