import SwiftUI
import UIKit

struct ProfileView: View {
    @State private var bannerImage: UIImage?
    @State private var profileImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var selectedImageType: ImageType?
    @State private var username: String = "Full Name" // ここでユーザー名を管理
    

    enum ImageType {
        case banner, profile
    }

    var body: some View {
        VStack {
            // バナー画像
            ZStack {
                if let bannerImage = bannerImage {
                    Image(uiImage: bannerImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                } else {
                    Image("DefaultBannerImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                }
                if bannerImage == nil {
                    Button(action: {
                        selectedImageType = .banner
                        isShowingImagePicker = true
                    }) {
                        Image(.header)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                    }
                }
            }

            // プロフィール画像
            ZStack {
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .offset(y: -50)
                        .padding(.bottom, -50)
                } else {
                    Image("DefaultProfileImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .offset(y: -50)
                        .padding(.bottom, -50)
                }

                if profileImage == nil {
                Button(action: {
                    selectedImageType = .profile
                    isShowingImagePicker = true
                }) {
                    Image(.icon1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .offset(y: -50)
                        .padding(.bottom, -50)
                    }
                }
            }

            // ユーザー名入力フィールド
            TextField("Enter your name", text: $username)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()

            // ユーザー ID
            Text("@This_is_ID")
                .foregroundColor(.gray)

            // 自己紹介
            Text("I'm a Software Engineer.")
                .padding()

            // フォロワー/フォロー数
            HStack {
                VStack {
                    Text("12")
                        .font(.title)
                        .bold()
                    Text("Following")
                        .foregroundColor(.gray)
                }
                .padding()

                VStack {
                    Text("98")
                        .font(.title)
                        .bold()
                    Text("Followers")
                        .foregroundColor(.gray)
                }
                .padding()
            }

            // 自分の投稿一覧
            VStack(alignment: .leading) {

                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(0..<10) { _ in
                            TweetRowView()
                        }
                    }
                    .padding()
                }
            }

            Spacer()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: selectedImageType == .banner ? $bannerImage : $profileImage)
        }
    }
}

struct TweetRowView: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("profileImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("John Doe")
                        .font(.headline)
                    Text("@johndoe")
                        .foregroundColor(.gray)
                    Text("・ 2h")
                        .foregroundColor(.gray)
                }

                Text("This is a sample feed. You can customize this view to display the actual tweet content, images, and other metadata.")
                    .padding(.top, 2)

                HStack {
                    Button(action: {}) {
                        Image(systemName: "bubble.left")
                            .font(.subheadline)
                    }

                    Button(action: {}) {
                        Image(systemName: "arrowshape.turn.up.left")
                            .font(.subheadline)
                    }

                    Button(action: {}) {
                        Image(systemName: "heart")
                            .font(.subheadline)
                    }

                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.subheadline)
                    }
                }
                .foregroundColor(.gray)
                .padding(.top, 8)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.editedImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
