//
//  SignInView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 2.08.2024.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    
    @Environment(\.primaryColor) private var primaryColor
    
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordSheet: Bool = false
    @State private var isHomeViewActive: Bool = false
    @State private var isSignUpViewActive: Bool = false
    @State private var loginError: String?
    @State private var showErrorAlert: Bool = false
    
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
                    CustomTextField(hint: "email", value: $emailID)
                    CustomTextField(hint: "şifre", isPassword: true, value: $password)
                    
                    HStack {
                        Spacer()
                        Button("Şifrenizi mi unuttunuz?") {
                            showForgotPasswordSheet.toggle()
                        }
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.trailing)
                    }
                                        
                    CustomButton(title: "Giriş Yap", color: primaryColor) {
                        validateAndSignIn()
                    }
                    CustomButton(image: "apple.logo", title: "Apple ile Giriş Yap", isSystemImage: true, color: .black) {}
                    CustomButton(image: "google.svg", title: "Google ile Giriş Yap", isSystemImage: false, color: .black) {}
                    
                }
                .padding()
                
                Spacer()
                
                // Kayıt olma kısmı
                HStack {
                    Text("Hesabınız yok mu?")
                        .foregroundColor(.gray)
                    Button(action: {
                        isSignUpViewActive = true
                    }) {
                        Text("Kayıt Ol")
                            .fontWeight(.bold)
                            .foregroundColor(primaryColor) 
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal)
        }
        .fullScreenCover(isPresented: $isSignUpViewActive) {
            SignUpView()
        }
        .fullScreenCover(isPresented: $isHomeViewActive) {
            HomeView()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Giriş Hatası"), message: Text(loginError ?? "Bilinmeyen bir hata oluştu"), dismissButton: .default(Text("Tamam")))
        }
    }
    
    private func validateAndSignIn() {
        if emailID.isEmpty || password.isEmpty {
            loginError = "Lütfen mailinizi ve şifrenizi giriniz."
            showErrorAlert = true
        }
        // Eger emailID gecerli bir email formatında degilse hata mesajı döndürür
        else if !isValidEmail(emailID) {
            loginError = "Lütfen geçerli bir e-posta adresi girin."
            showErrorAlert = true
        }
        else {
            signIn()
        }
    }

    // Email adresinin geçerli olup olmadığını kontrol eden fonksiyon
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    // Firebase ile giriş yapma fonksiyonu
    private func signIn() {
        Auth.auth().signIn(withEmail: emailID, password: password) { result, error in
            if let error = error {
                loginError = error.localizedDescription
                showErrorAlert = true
            } else {
                isHomeViewActive = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
