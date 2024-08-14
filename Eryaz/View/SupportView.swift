//
//  SupportView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 5.08.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct SupportView: View {
    @Environment(\.primaryColor) private var primaryColor

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var selectedTopic: String = "Yazilim"
    @State private var message: String = ""
    @State private var isSending: Bool = false
    @State private var errorMessage: String?
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var imageURL: String?

    // Firestore veritabanı ve depolama referansları
    private var db = Firestore.firestore()
    private var storage = Storage.storage().reference()

    // Seçim menüsü için konular
    private let topics = ["B2B", "B4B", "D2D", "S4B", "ZEUS", "ERYAZ TICKETING"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("logo")
                    .padding(10)

                Group{
                    CustomTextField(hint: "Ad", value: $name)
                    CustomTextField(hint: "E-posta", value: $email)

                    Menu {
                        ForEach(topics, id: \.self) { topic in
                            Button(action: {
                                selectedTopic = topic
                            }) {
                                Text(topic)
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedTopic)
                                .foregroundColor(selectedTopic == "Yazilim" ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 0.9)
                    )
                    .padding(.horizontal, 10)

                    Text("Mesaj")
                        .padding(.horizontal)
                        .foregroundColor(.gray)

                    CustomTextArea(hint: "Mesajınızı girin", value: $message)
                    
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Text(selectedImage != nil ? "Görsel Seçildi" : "Görsel Seç")
                            .foregroundColor(primaryColor)
                    }
                    .padding()
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    }
                }
                .padding(.horizontal, 20)

                CustomButton(title: "Gönder", color: primaryColor) {
                    sendFeedback()
                }
                .padding(.horizontal, 30)
                .disabled(isSending) // Butonu gönderme işlemi sırasında devre dışı bırak

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: {
                    // Add action for call support
                }) {
                    Text("Daha fazla destek için bizi arayın")
                        .foregroundColor(primaryColor.opacity(0.5))
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }

    // Geri bildirim gönderme işlevi
    private func sendFeedback() {
        guard !name.isEmpty, !email.isEmpty, !selectedTopic.isEmpty, !message.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }

        isSending = true
        errorMessage = nil

        var feedbackData: [String: Any] = [
            "ad": name,
            "e-posta": email,
            "konu": selectedTopic,
            "mesaj": message,
            "zaman damgası": Timestamp()
        ]

        // Görsel varsa, önce onu Firestore Storage'a yükle
        if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.8) {
            let imageRef = storage.child("images/\(UUID().uuidString).jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageRef.putData(imageData, metadata: metadata) { _, error in
                if let error = error {
                    errorMessage = "Görsel yüklenirken hata oluştu: \(error.localizedDescription)"
                    isSending = false
                    return
                }
                
                // Görselin URL'sini al ve veriye ekle
                imageRef.downloadURL { url, error in
                    if let error = error {
                        errorMessage = "Görsel URL alınırken hata oluştu: \(error.localizedDescription)"
                        isSending = false
                        return
                    }
                    
                    if let imageURL = url?.absoluteString {
                        feedbackData["gorsel"] = imageURL
                    }

                    // Veriyi Firestore koleksiyonuna ekleme kısmı
                    db.collection("support").addDocument(data: feedbackData) { error in
                        if let error = error {
                            errorMessage = "Geri bildirim gönderilirken hata oluştu: \(error.localizedDescription)"
                        } else {
                            name = ""
                            email = ""
                            selectedTopic = "Seçiniz"
                            message = ""
                            selectedImage = nil
                        }
                        isSending = false
                    }
                }
            }
        } else {
            // Görsel yoksa sadece geri bildirimi gönder
            db.collection("support").addDocument(data: feedbackData) { error in
                if let error = error {
                    errorMessage = "Geri bildirim gönderilirken hata oluştu: \(error.localizedDescription)"
                } else {
                    name = ""
                    email = ""
                    selectedTopic = "Seçiniz"
                    message = ""
                    selectedImage = nil
                }
                isSending = false
            }
        }
    }
}

struct CustomTextArea: View {
    var hint: String
    @Binding var value: String

    var body: some View {
        TextEditor(text: $value)
            .frame(height: 150)
            .padding(30)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
    }
}

#Preview {
    SupportView()
}
