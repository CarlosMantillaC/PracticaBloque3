//
//  ThemeManager.swift
//  PracticaBloque3
//
//  Created by Gopenux on 19/06/25.
//

import Foundation

final class ThemeManager {
    static let shared = ThemeManager()
    private init() {}

    private(set) var currentTheme: String = "light"

    func toggleTheme() {
        currentTheme = currentTheme == "light" ? "dark" : "light"
        NotificationCenter.default.post(name: .themeChanged, object: nil, userInfo: ["theme": currentTheme])
    }
}

