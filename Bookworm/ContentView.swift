//
//  ContentView.swift
//  Bookworm
//
//  Created by Yuki Shinohara on 2020/04/09.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) var moc
    //    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    //    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)]) var books: FetchedResults<Book>
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                //                                challenge2
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            
                            Text(book.author ?? "Unknown Author")
//                            Text(book.author == "" ? "Unknown Author" : book.author)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                    .onDelete(perform: deleteBooks) //ForEachに付随させる Listでない
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                    //                            Write values in the environment, which is done using a modifier of the same name, environment(), which takes two parameters: a key to write to, and the value you want to send in. For the key we can just send in the one we’ve been using all along, \.managedObjectContext, and for the value we can pass in our own moc property – we’re effectively just forwarding it on.
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
