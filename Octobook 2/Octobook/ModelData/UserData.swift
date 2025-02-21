/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
Storage for model data.
*/

import Foundation


class UserData: ObservableObject {
    @Published var users: [User] = []

        private let fileName = "userData.json"

        init() {
            loadUsers()
        }

        func loadUsers() {
            // First try to load from documents directory
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: url.path) {
                if let data = try? Data(contentsOf: url),
                   let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                    self.users = decodedUsers
                    return
                }
            }
            
            // If that fails, load from bundle
            if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil),
               let data = try? Data(contentsOf: bundleURL),
               let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                self.users = decodedUsers
                // Save bundle data to documents for future use
                saveUsers()
            } else {
                print("❌ Could not load users from bundle or documents directory")
            }
        }

        private func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }

        func toggleReadStatus(for user: User) {
            if let index = users.firstIndex(where: { $0.id == user.id }) {
                users[index].isRead.toggle()
                saveUsers()
            }
        }
        
        func updateRating(for user: User, to rating: Int) {
            if let index = users.firstIndex(where: { $0.id == user.id }) {
                users[index].rating = min(max(rating, 0), 5) // Ensure rating is between 0-5
                saveUsers()
            }
        }
        
        private func saveUsers() {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            if let data = try? JSONEncoder().encode(users) {
                try? data.write(to: url)
            }
        }

        func addUser(_ user: User) {
            users.append(user)
            saveUsers()
        }
}
