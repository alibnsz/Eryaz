// CustomButton.swift
// Eryaz
// Created by Mehmet Ali Bunsuz on 7.08.2024.

import SwiftUI

struct CustomButton: View {
    
    var image: String?
    var title: String
    var isSystemImage: Bool = false
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if let image = image {
                    if isSystemImage {
                        Image(systemName: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                    } else {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(17)
            .background(color)
            .cornerRadius(20)
        }
        .padding(.horizontal, 10)
    }
}


