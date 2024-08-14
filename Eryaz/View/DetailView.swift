//
//  DetailView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 1.08.2024.
//

import SwiftUI

struct DetailView: View {
    let detail: ModelElement
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: detail.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                } placeholder: {
                    ProgressView()
                }
                
                Text(detail.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ScrollView {
                    Text(detail.description)
                        .font(.body)
                        .padding()
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(detail.title), displayMode: .inline)
        }
    }
}

#Preview {
    DetailView(detail: ModelElement(title: "", description: "", imageURL: ""))
}
