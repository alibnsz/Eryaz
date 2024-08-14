//
//  EryazApp.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 30.07.2024.
//

import SwiftUI
import FirebaseCore

@main
struct EryazApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            IntroView()
                .environment(\.primaryColor, .primaryRed)
        }
    }
}

