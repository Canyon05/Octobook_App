import SwiftUI

struct FavoriteBooksPicker: View {
    @ObservedObject var bookData: BookData
    @ObservedObject var userData: UserData
    var user: User
    @Environment(\.dismiss) var dismiss
    @State private var selectedBookIds: Set<String>
    
    init(bookData: BookData, userData: UserData, user: User) {
        self.bookData = bookData
        self.userData = userData
        self.user = user
        // Initialize selection with user's current favorite books
        _selectedBookIds = State(initialValue: user.favoriteBookIds)
    }
    
    var body: some View {
        NavigationView {
            List(bookData.books) { book in
                HStack {
                    BookRow(bookData: bookData, book: book)
                        .frame(height: 100)
                    Spacer()
                    if selectedBookIds.contains(book.id) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleSelection(for: book)
                }
            }
            .navigationTitle("Select Favorite Books")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveChanges()
                    dismiss()
                }
            )
        }
    }
    
    private func toggleSelection(for book: Book) {
        if selectedBookIds.contains(book.id) {
            selectedBookIds.remove(book.id)
        } else if selectedBookIds.count < 3 {
            selectedBookIds.insert(book.id)
        }
    }
    
    private func saveChanges() {
        guard let index = userData.users.firstIndex(where: { $0.id == user.id }) else { return }
        var updatedUser = user
        updatedUser.favoriteBookIds = selectedBookIds
        userData.users[index] = updatedUser
        userData.saveUsers()
    }
} 
