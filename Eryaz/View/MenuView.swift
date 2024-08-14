//
//  MenuView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 1.08.2024.
//

import SwiftUI

struct MenuView: View {

    @Environment(\.primaryColor) private var primaryColor

    let urls = UrlModel.sampleData

    var body: some View {
            VStack(spacing: 25) {
                Image("logo")
                ScrollView {
                    VStack(spacing: 45) {
                        ForEach(0..<urls.count, id: \.self) { index in
                            Button(action: {
                                if let url = URL(string: urls[index].url) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                ZStack {
                                    Image("")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 300, height: 70)
                                        .background(.gray.opacity(0.3))
                                        .blur(radius: 60)
                                        .cornerRadius(30)
                                    HStack {
                                        Text(urls[index].title)
                                            .foregroundColor(primaryColor)
                                            .fontWeight(.bold)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
        
    }
}

#Preview {
    MenuView()
}
