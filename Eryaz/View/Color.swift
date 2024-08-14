//
//  Color.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 7.08.2024.
//

import SwiftUI // SwiftUI çerçevesini içe aktarır.

extension Color {
    static let primaryRed = Color(red: 0.5, green: 0, blue: 0) 
}

private struct PrimaryColorKey: EnvironmentKey {
    static let defaultValue: Color = .primaryRed
}

extension EnvironmentValues {
    var primaryColor: Color {
        get { self[PrimaryColorKey.self] }
        set { self[PrimaryColorKey.self] = newValue }
    }
}

