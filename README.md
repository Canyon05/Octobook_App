# Octobook_App
#### Video Demo:  https://www.youtube.com/watch?v=skb-QUrJJpw
#### Description:

Octobook is an IOS-App, where the user can log and review books they've read.The User can add books using th add button in the library tap.

In the library tab is also a filter function, for filtering books by rating, category and read status.

The user can costumize the profile view, where they can show off their favorite books and journal entries. the backgroundimage and profilepicture are also costumizable.

In the current reading tab is the journal feature implemented. The user can add journal entries with date, pages read and can write down some thoughts while reading these pages. The journal entries are sorted for each book.

![Screenshot of the Library tab in the OctobookApp.](/Images/IMG_5038.PNG){ width=250}![Screenshot of the Library tab in the OctobookApp.](/Images/IMG_5039.PNG){ width=250}![Screenshot of the Library tab in the OctobookApp.](/Images/IMG_5040.PNG){ width=250}

---
### [ContentView](/Octobook/Octobook/View/ContentView.swift)

The App is generally based on the bookListView, profileView and the journalView. These views are accessible by using the Tabview (Navigationbar at the bottom of the contentView).

![Screenshot of the App, showing the TabView navigation](/Images/screenshot_TabView.PNG)

There are three Tabview items in the Tabview navigationbar. 
**The first Item (on the left) is linked to _booklistView_**, with a systemsymbol ("Books.vertical.filled") and a Text saying "library".
**The second Item (in the middle) is linked to _profileView_**, with a systemsymbol ("person.fill") and a Text saying "Profile".
**The third Item (on the right) is linked to _journalView_**, with a systemsymbol ("book.pages") and a Text saying "Current Book".

---

### [Library](/Octobook/Octobook/View/BookList.swift)

The Library is coded in the "BookList" file. This View is constructed using "NavigationSplitView". In the "NavigationSplitView" is a section with a header ("Filters") for the filtermenu. Each filter is build using "Menu" and a dynamic "label".

![Screenshot of the Filtersection in the BookList view](/Images/screenshot_FilterMenu.jpeg)

The following section is the booklist. It displays a "NavigationLink" for each Book in the Lybrary that meets the filter the user hat set. The navigationlink's destination is "BookDetails" View, for that specific book. Also the navigationlink is displayed using "BookRow". I made the "listRowBackground" white and reduced the opacity. There is also a "SwipeAction", for deleting books from the library. If there are no books in the library, that meets the filters set by the user, there will be a text, saying "No Books match your filers.".

![Screenshot of the BookList Section](/Images/screenshot_Booklist.jpeg)

The BookListView has two private functions.
The "deleteBooks" function sets a Animation and calls the deleteBook function in BookData. this function is for the swipeAction(single deletion).
The "deleteSelectedBook" function is for deleting selected books (multible). It calls deleteBook function from BookData but for all selected books.

The Background is an self-drawn Image. there is a small Animation, for filtering books. The "Toolbar" has two "Toolbaritems". One Toolbaritem is for editing and the other is for adding a Book.

If you edit the library, using the toolbaritem called edit, you can choose the books you want to delet. You have to confirm the deletion (there will be an Allert asking you to confirm).

###### adding a book
The adding a book button opens the "AddBookView". The "AddBookView" let the user add a new book to their library. Whats most intresting about this view, is how the new bookdata is being stored. There is a private function called "addBook". It saves the Image if selected and creates a new bookdata with explicit parameter names. After the new Bookdata is completely created, the function calls the "addBook" function from the "BookData" to add it to the Library (BookData).

---

In the view folder are also other SwiftUI files that are mostly for keeping the main view files clean and organized.

### Data storing

This project is based on three Data storing models. One for the Bookdata, Userdata and Journaldata. All three Data models are based on the same principles. 
Data is stored as JSON in the Documents Directory. The data is loaded from that JSON file or from the app bundle if missing. Changes are saved persistently.


##### Here is a detailed desciption of the Bookdata model. The construction and principles are the same for User and Journal data.

**Storage location** :
Books are stored in a JSON file ("BookData.json") inside the documents directory. If not found, data is loaded from the app bundle and then saved to the documents directory for future use.
**Data structure** :
Each book is stored as a JSON object with properties like id, name, author, rating, is Read, pages and imageName.
**Loading data** (loadBooks()):
First it tries to load from the documents directory. If missing, it loads from the App bundle and saves it.
**Saving data** (saveBooks()):
Whenever books are modified (read status, rating, progress, etc.), changes are saved back to bookData.json.
**Modifying data** :
•	toggleReadStatus(): Marks a book as read/unread.
•	updateRating(): Updates the book’s rating (0-5).
•	updateProgress(): Tracks reading progress, marking as read if completed.
•	addBook(): Adds a new book.
•	deleteBook(): Removes a book.
**Book images** :
Book images are stored either in the documents directory or the app bundle. The app checks for an image in the documents directory first befor using the default one.
**When the app is restarts**, the data is loaded from the documents directory (or app bundle, if missing). Any modifications presist because changes are saved immediately. 



