//
//  HomeView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 31.07.2024.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @State private var isIntroViewActive: Bool = false
    @Environment(\.primaryColor) private var primaryColor

    var body: some View {
        NavigationView {
            VStack (spacing: 25) {
                NavigationLink(destination: MapsView()) {
                    Image("logo")
                }
                ScrollView {
                    VStack(spacing: 45) {
                        ForEach(viewModel.details, id: \.title) { detail in
                            NavigationLink(destination: DetailView(detail: detail)) {
                                ZStack {
                                    AsyncImage(url: URL(string: detail.imageURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 350, height: 170)
                                            .clipped()
                                            .cornerRadius(30)
                                            .blur(radius: 0.5)
                                            .shadow(radius: 10)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 350, height: 170)
                                    }
                                    Text(detail.title)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: SupportView()) {
                        Image(systemName: "bubble")
                            .imageScale(.large)
                            .foregroundColor(primaryColor)
                    }
                    Button(action: {
                        isIntroViewActive = true
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .imageScale(.large)
                            .foregroundColor(primaryColor)
                    }
                }
            )
            .navigationBarItems(leading:
                    NavigationLink(destination: MenuView()) {
                        Image(systemName: "text.alignright")
                            .imageScale(.large)
                            .foregroundColor(primaryColor)
                }
            )
            .fullScreenCover(isPresented: $isIntroViewActive) {
                IntroView()
            }
        }
        .accentColor(primaryColor)
    }
}

#Preview {
    HomeView()
}
