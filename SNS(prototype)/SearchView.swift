import SwiftUI

struct SearchView: View {
   @State private var searchText = ""
   @State private var searchResults: [SearchResult] = []
   
   var body: some View {
       NavigationView {
           VStack {
               SearchBar(text: $searchText, onSearchButtonClicked: search)
                   .padding()
               
               if searchResults.isEmpty {
                   Text("Search for users or keywords")
                       .foregroundColor(.gray)
                       .padding()
               } else {
                   List(searchResults) { result in
                       SearchResultCell(result: result)
                   }
               }
           }
           .navigationBarTitle("Search", displayMode: .automatic)
       }
   }
   
   private func search() {
       // APIから検索結果を取得するロジックを実装
       let mockResults = [
           SearchResult(username: "johndoe", name: "John Doe", isUser: true),
           SearchResult(keyword: "SwiftUI", count: 1234, isUser: false),
           SearchResult(username: "janedoe", name: "Jane Doe", isUser: true),
           SearchResult(keyword: "iOS Development", count: 5678, isUser: false)
       ]
       searchResults = mockResults.filter { result in
           if let username = result.username {
               return username.contains(searchText)
           } else if let keyword = result.keyword {
               return keyword.contains(searchText)
           }
           return false
       }
   }
}

struct SearchBar: View {
   @Binding var text: String
   var onSearchButtonClicked: () -> Void
   
   var body: some View {
       HStack {
           TextField("Search...", text: $text)
               .textFieldStyle(RoundedBorderTextFieldStyle())
           
           Button(action: onSearchButtonClicked) {
               Image(systemName: "magnifyingglass")
           }
           .foregroundColor(.blue)
       }
       .padding()
   }
}

struct SearchResultCell: View {
   let result: SearchResult
   
   var body: some View {
       HStack {
           if result.isUser {
               Image(systemName: "person.circle.fill")
                   .foregroundColor(.gray)
               
               VStack(alignment: .leading) {
                   if let name = result.name {
                       Text(name)
                   } else {
                       Text("")
                   }
                   Text("@\(String(describing: result.username))")
                       .foregroundColor(.gray)
               }
           } else {
               Image(systemName: "hashtag")
                   .foregroundColor(.gray)
               
               VStack(alignment: .leading) {
                   if let keyword = result.keyword {
                       Text(keyword)
                   } else {
                       Text("")
                   }
                   Text("\(String(describing: result.count)) Tweets")
                       .foregroundColor(.gray)
               }
           }
       }
   }
}

struct SearchResult: Identifiable {
   let id = UUID()
   let username: String?
   let name: String?
   let keyword: String?
   let count: Int?
   let isUser: Bool
   
   init(username: String, name: String, isUser: Bool) {
       self.username = username
       self.name = name
       self.isUser = isUser
       self.keyword = nil
       self.count = nil
   }
   
   init(keyword: String, count: Int, isUser: Bool) {
       self.keyword = keyword
       self.count = count
       self.isUser = isUser
       self.username = nil
       self.name = nil
   }
}

struct SearchView_Previews: PreviewProvider {
   static var previews: some View {
       SearchView()
   }
}
