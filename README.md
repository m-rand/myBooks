# myBooks

Just a simple „proof-of-concept“ app demo for searching books via [OpenLibrary](https://openlibrary.org) developer API. App is written using SwiftUI and Combine frameworks.  

There are two tabs in the app:
- Search Subjects: searches for 10 books related to given subject (e.g. „love“, „death“, „art“, …).
- Search Title: searches for all books containing given string and displays them in a list grouped by author’s name and sorted by number of books.

All results are displayed in a lazy list with book covers loaded asynchronously using [NetworkImage](https://stackoverflow.com/a/64416344). When no cover is available, a „photo“ placeholder is used. 

Searching and fetching data from server is live with 1s time interval. 

——

This demo is inspired by [Combine networking with a hint of SwiftUI](https://engineering.nodesagency.com/categories/ios/2020/03/16/Combine-networking-with-a-hint-of-swiftUI) blog post.
