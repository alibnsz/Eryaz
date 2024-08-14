//
//  CustomTextField.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 2.08.2024.
//

import SwiftUI

struct CustomTextField: View {
    var iconTint: Color = .gray
    var hint: String
    var isPassword: Bool = false
    
    @Binding var value: String
    
    @State private var showPassword: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .leading) {
                    if value.isEmpty {
                        Text(hint)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 26)
                            .font(.system(size: 16, weight: .regular))
                    }
                    if isPassword {
                        Group {
                            if showPassword {
                                SecureField("", text: $value)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 0.9)
                                    )
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(.horizontal,10)


                            } else {
                                TextField("", text: $value)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 0.9)
                                    )
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(.horizontal,10)
                            }
                            
                        }
                        
                    } else {
                        TextField("", text: $value)
                            .foregroundColor(.black)
                            .accentColor(.black)
                            .padding(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 0.9)
                            )
                            .font(.system(size: 16, weight: .regular))
                            .padding(.horizontal,10)

                    }
                }
                .frame(maxWidth: .infinity)
            }
            .overlay(alignment: .trailing) {
                if isPassword {
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                    .padding(.horizontal)
                }
            }
        }
        .foregroundColor(.white)
    }
    
}

#Preview {
    SignInView()
}

