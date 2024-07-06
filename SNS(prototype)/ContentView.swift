import SwiftUI

struct YourAppName: App { // ここでエントリーポイントを設定
    var body: some Scene {
        WindowGroup {
            MainView() // ここでMainViewをルートビューとして設定
        }
    }
}

struct MainView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            SearchView() // SearchViewが定義されていることを確認
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            ProfileView() // ProfileViewが定義されていることを確認
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

struct ContentView: View {
    @State private var showCreateTweetView = false
    @State private var tweets: [Tweet] = [] // ここでtweetsを定義

    var body: some View {
        NavigationView {
            List(tweets) { tweet in // ツイートデータを表示するコード
                TweetCell(tweet: tweet) // TweetCellを表示
            }
            .navigationBarTitle("Home")
            .navigationBarItems(trailing: createTweetButton)
            .onAppear {
                fetchTweets()
            }
        }
        .sheet(isPresented: $showCreateTweetView) {
            CreateTweetView()
        }
    }

    private var createTweetButton: some View {
        Button(action: { showCreateTweetView = true }) {
            Image(systemName: "pencil")
        }
    }
    
    private func fetchTweets() {
        // APIからツイートデータを取得するロジックを実装
        let mockTweets = [
            Tweet(username: "johndoe", content: "Hello, CampBase!", timestamp: Date()),
            Tweet(username: "janedoe", content: "Enjoying a beautiful day! ☀️", timestamp: Date().addingTimeInterval(-3600)),
            Tweet(username: "bobsmith", content: "Working on a new project. Exciting times! 💻", timestamp: Date().addingTimeInterval(-7200))
        ]
        tweets = mockTweets // ここでtweetsを設定
    }
}

struct TweetCell: View {
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(tweet.username)
                        .font(.headline)
                    
                    Text("@\(tweet.username)")
                        .foregroundColor(.gray)
                }
            }
            
            Text(tweet.content)
                .padding(.vertical, 8)
            
            HStack {
                Button(action: {
                    // リプライ処理を実装
                }) {
                    Image(systemName: "bubble.left")
                    Text("Reply")
                }
                
                Spacer()
                
                Button(action: {
                    // いいね処理を実装
                }) {
                    Image(systemName: "heart")
                    Text("Like")
                }
                
                Spacer()
                
                Button(action: {
                    // シェア処理を実装
                }) {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
            }
            .foregroundColor(.gray)
            .font(.footnote)
        }
        .padding()
    }
}

struct Tweet: Identifiable {
    let id = UUID()
    let username: String
    let content: String
    let timestamp: Date
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
