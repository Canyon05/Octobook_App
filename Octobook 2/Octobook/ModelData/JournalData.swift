/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
Storage for model data.
*/

import Foundation


class JournalData: ObservableObject {
    @Published var blogs: [Blog] = []

        private let fileName = "journalData.json"

        init() {
            loadBlogs()
        }

        func loadBlogs() {
            // First try to load from documents directory
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: url.path) {
                if let data = try? Data(contentsOf: url),
                   let decodedBlogs = try? JSONDecoder().decode([Blog].self, from: data) {
                    self.blogs = decodedBlogs
                    return
                }
            }
            
            // If that fails, load from bundle
            if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil),
               let data = try? Data(contentsOf: bundleURL),
               let decodedBlogs = try? JSONDecoder().decode([Blog].self, from: data) {
                self.blogs = decodedBlogs
                // Save bundle data to documents for future use
                saveBlogs()
            } else {
                print("❌ Could not load users from bundle or documents directory")
            }
        }

        private func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
        
        private func saveBlogs() {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            if let data = try? JSONEncoder().encode(blogs) {
                try? data.write(to: url)
            }
        }

        func addBlog(_ blog: Blog) {
            blogs.append(blog)
            saveBlogs()
        }
}
