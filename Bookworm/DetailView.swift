//
//  DetailView.swift
//  Bookworm
//
//  Created by Yuki Shinohara on 2020/04/09.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import CoreData
//import SafariServices

struct DetailView: View {
    
    // whether or not to show the Safari ViewController
    //    @State var showSafari = false
    // initial URL string
    //    @State var urlString = "https://duckduckgo.com"
    
    let book: Book //渡されてきたデータ
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    func deleteBook() {
        moc.delete(book)
        
        // uncomment this line if you want to make the deletion permanent
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    //    challenge 3
    var formattedDate: String {
        print(book)
        if let date = book.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "ja_JP")
            return formatter.string(from: date)
            
        } else {
            return "N/A"
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Mystery")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Text(self.formattedDate).padding()
                
                //                Button(action: {
                //                    // update the URL if you'd like to
                //                    self.urlString = "https://duckduckgo.com"
                //                    // tell the app that we want to show the Safari VC
                //                    self.showSafari = true
                //                }) {
                //                    Text("Present Safari")
                //                }
                //                .padding()
                
                
                Spacer()
            }
            //            .sheet(isPresented: self.$showSafari) {
            //                SafariView(url:URL(string: self.urlString)!)
            //            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
}

//struct SafariView: UIViewControllerRepresentable {
//
//let url: URL
//
//func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
//    return SFSafariViewController(url: url)
//}
//
//func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
//
//}
//}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
