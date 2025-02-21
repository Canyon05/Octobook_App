import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var bookData: BookData
    
    @State private var name: String = ""
    @State private var author: String = ""
    @State private var category: String = ""
    @State private var description: String = ""
    @State private var rating: Int = 0
    @State private var isRead: Bool = false
    @State private var pages: String = ""
    @State private var progress: String = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var isFormValid: Bool {
        !name.isEmpty && !author.isEmpty && !category.isEmpty && !description.isEmpty && !pages.isEmpty && !progress.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Book Title", text: $name)
                    TextField("Author", text: $author)
                    TextField("Category", text: $category)
                    TextField("Pages", text: $pages)
                        .keyboardType(.numberPad)
                    TextField("Progress", text: $progress)
                        .keyboardType(.numberPad)
                    
                    Toggle("Already Read", isOn: $isRead)
                }
                
                Section(header: Text("Rating")) {
                    StarRating(rating: rating, size: 24) { newRating in
                        rating = newRating
                    }
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Cover Image")) {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        HStack {
                            Text(selectedImage != nil ? "Change Image" : "Select Image")
                            Spacer()
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addBook()
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
    
    private func addBook() {
        // Save image if selected
        var imageName = "DefaultBookCover"
        if let image = selectedImage {
            imageName = "Book_\(UUID().uuidString)"
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = getDocumentsDirectory().appendingPathComponent("\(imageName).jpg")
                try? data.write(to: filename)
            }
        }
        
        // Create new book with explicit parameter names
        let newBook = Book(
            id: UUID().uuidString,
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            category: category.trimmingCharacters(in: .whitespacesAndNewlines),
            author: author.trimmingCharacters(in: .whitespacesAndNewlines),
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            rating: rating,
            isRead: isRead,
            pages: pages,
            progress: progress,
            imageName: imageName
        )
        
        // Add to BookData
        bookData.addBook(newBook)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

// Image Picker for selecting book cover
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.dismiss()
        }
    }
} 
