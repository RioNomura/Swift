import SwiftUI

struct CreateTweetView: View {
    @State private var tweetText: String = ""
    @State private var selectedImage: UIImage? = nil
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                        .frame(maxHeight: 200)
                        .padding(.bottom)
                    
                    Button(action: { selectedImage = nil }) {
                        Text("Remove Image")
                            .foregroundColor(.red)
                    }
                } else {
                    Button(action: { showImagePicker() }) {
                        Text("Add Image")
                            .foregroundColor(.blue)
                    }
                }

                TextEditor(text: $tweetText)
                    .frame(minHeight: 100)
                    .padding()

                Spacer()

                Button(action: postTweet) {
                    Text("Tweet")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(16)
                        .disabled(tweetText.isEmpty)
                }
                .padding()
            }
            .navigationBarTitle("Create Tweet", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: postButton)
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $selectedImage)
            }
        }
    }

    @State private var isShowingImagePicker = false

    private func showImagePicker() {
        isShowingImagePicker = true
    }

    private func loadImage() {
        // 画像を読み込む処理を行う
    }

    private var cancelButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Text("Cancel")
        }
    }

    private var postButton: some View {
        Button(action: postTweet) {
            Text("Tweet")
        }
        .disabled(tweetText.isEmpty)
    }

    private func postTweet() {
        // ツイート投稿のロジックを実装
        print("Tweet: \(tweetText)")
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateTweetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTweetView()
    }
}
