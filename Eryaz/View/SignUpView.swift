//
//  SignUpView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 5.08.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    
    @Environment(\.primaryColor) private var primaryColor
    
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var surName: String = ""
    @State private var passwordAgain: String = ""
    @State private var showForgotPasswordSheet: Bool = false
    @State private var isHomeViewActive: Bool = false
    @State private var isSignInViewActive: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button("Geç") {
                        isHomeViewActive = true
                    }
                    .foregroundColor(.gray.opacity(0.5))
                }
                Spacer()
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 70)
                        .foregroundColor(.gray)
                        .padding(40)
                    
                    CustomTextField(hint: "Ad", value: $name)
                    CustomTextField(hint: "Soyad", value: $surName)
                    CustomTextField(hint: "E-posta", value: $emailID)
                    CustomTextField(hint: "Şifre", isPassword: true, value: $password)
                    CustomTextField(hint: "Şifreyi Tekrarla", isPassword: true, value: $passwordAgain)
                    
                    // Kayıt ol butonu
                    CustomButton(title: "Kayıt Ol", color: primaryColor) {
                        signUp()
                    }
                    
                }
                .padding()
                Spacer()
                HStack(spacing: 5) {
                    Text("Zaten hesabınız var mı?")
                        .foregroundColor(.gray)
                    Button(action: {
                        isSignInViewActive = true
                    }) {
                        Text("Giriş Yap")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.5, green: 0, blue: 0))
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal)
        }
        // Hata mesajı için alert
        .alert(isPresented: $showError) {
            Alert(title: Text("Hata"), message: Text(errorMessage), dismissButton: .default(Text("Tamam")))
        }
        .fullScreenCover(isPresented: $isSignInViewActive) {
            SignInView()
        }
        .fullScreenCover(isPresented: $isHomeViewActive) {
            HomeView()
        }
    }

    // Kullanıcıyı kaydetme fonksiyonu
    func signUp() {
        // Şifreler eşleşiyor mu kontrol et
        guard password == passwordAgain else {
            errorMessage = "Şifreler uyuşmuyor"
            showError = true
            return
        }
        
        // Firebase Auth ile kullanıcı kaydı
        Auth.auth().createUser(withEmail: emailID, password: password) { authResult, error in
            if error != nil {
                errorMessage = "Lütfen bütün alanları doldurun."
                showError = true
                return
            }
            
            guard let user = authResult?.user else {
                errorMessage = "Kullanıcı oluşturma başarısız oldu"
                showError = true
                return
            }
            
            // Kullanıcı bilgilerini Firestore'a kaydet
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "ad": name,
                "soyad": surName,
                "email  ": emailID,
            ]) { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                    showError = true
                } else {
                    isHomeViewActive = true
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
