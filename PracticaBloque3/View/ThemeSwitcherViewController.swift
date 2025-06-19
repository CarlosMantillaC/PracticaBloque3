//
//  ThemeSwitcherViewController.swift
//  PracticaBloque3
//
//  Created by Gopenux on 19/06/25.
//

import UIKit

class ThemeSwitcherViewController: UIViewController {

    private let presenter = ThemePresenter()

    private lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tema", for: .normal)
        button.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observerChangeTheme()
        applyTheme(presenter.getCurrentTheme())
    }

    
    private func setupUI() {
        view.addSubview(toggleButton)
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


    private func observerChangeTheme() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleThemeChanged),
            name: .themeChanged,
            object: nil
        )
    }

    @objc private func handleThemeChanged() {
        let theme = presenter.getCurrentTheme()
        applyTheme(theme)
    }

    private func applyTheme(_ theme: ThemeType) {
        switch theme {
        case .light:
            view.backgroundColor = .white
            toggleButton.setTitle("Modo Oscuro", for: .normal)
            toggleButton.setTitleColor(.black, for: .normal)
        case .dark:
            view.backgroundColor = .black
            toggleButton.setTitle("Modo Claro", for: .normal)
            toggleButton.setTitleColor(.white, for: .normal)
        }
    }

    @objc private func changeTheme() {
        presenter.toggleTheme()
    }
}

