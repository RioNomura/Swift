// TweetStore.swift
import Combine

class TweetStore: ObservableObject {
    @Published var tweets: [Tweet] = []

    func addTweet(_ tweet: Tweet) {
        tweets.append(tweet)
    }
}
