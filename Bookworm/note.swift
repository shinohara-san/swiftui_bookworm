//https://www.hackingwithswift.com/books/ios-swiftui/creating-a-custom-component-with-binding
            //@Bindingについて
//
//struct ContentView: View {
//    @State private var rememberMe = false
//
//    var body: some View {
//        VStack {
//            PushButton(title: "Remember Me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//    }
//}
//
//struct PushButton: View {
//    let title: String
////    @State var isOn: Bool
//    //@StateだとPushButton内部でしか値の変更が有効でない
//    @Binding var isOn: Bool
//    //@Bindingを使うとContentViewにも飛んでいく
//
//    var onColors = [Color.red, Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white: 0.4)]
//
//    var body: some View {
//        Button(title) {
//            self.isOn.toggle()
//        }
//        .padding()
//        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//        .shadow(radius: isOn ? 0 : 5)
//    }
//}


//https://www.hackingwithswift.com/books/ios-swiftui/using-size-classes-with-anyview-type-erasure
             //AnyViewについて(どこでも使うとパフォーマンスが悪くなる)

//struct ContentView: View {
//    @Environment(\.horizontalSizeClass) var sizeClass
//
//    var body: some View {
//       if sizeClass == .compact {
////        AnyView, which is what’s called a type erased wrapper.
////        Externally AnyView doesn’t expose what it contains – Swift sees our condition as returning either an AnyView or an AnyView, so it’s considered the same type.
//            return AnyView(VStack {
//                Text("Active size class:")
//                Text("COMPACT")
//            }
//            .font(.largeTitle))
//        } else {
//            return AnyView(HStack {
//                Text("Active size class:")
//                Text("REGULAR")
//            }
//            .font(.largeTitle))
//        }
//    }
//}


//https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
                    //Core Dataについて

//@Environment(\.managedObjectContext) var moc
//
//@FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
////a fetch request for our “Student” entity, applies no sorting, and places it into a property called students that has the the type FetchedResults<Student>.
//
//
//    var body: some View {
//            VStack {
//                List {
//                    ForEach(students, id: \.id) { student in
//                        Text(student.name ?? "Unknown")
//                    }
//                }
//
//                Button("Add") {
//                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
//
//                    let chosenFirstName = firstNames.randomElement()!
//                    let chosenLastName = lastNames.randomElement()!
//
//                    let student = Student(context: self.moc)
//                    student.id = UUID()
//                    student.name = "\(chosenFirstName) \(chosenLastName)"
//
//                    try? self.moc.save()
//                }
//
//            }
//    }
//}


//Cant Undestand
//            https://www.hackingwithswift.com/books/ios-swiftui/adding-a-custom-star-rating-component
