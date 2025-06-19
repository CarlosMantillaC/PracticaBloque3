//
//  ThemePresenter.swift
//  PracticaBloque3
//
//  Created by Gopenux on 19/06/25.
//

import Foundation

enum ThemeType: String {
    case light
    case dark
}

final class ThemePresenter {
    
    private let themeManager = ThemeManager.shared

    func getCurrentTheme() -> ThemeType {
        return ThemeType(rawValue: themeManager.currentTheme) ?? .light
    }

    func toggleTheme() {
        themeManager.toggleTheme()
    }
}
