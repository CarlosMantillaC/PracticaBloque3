//
//  MainEditViewController.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import UIKit



class MainEditViewController: UIViewController {
    
    deinit {
        print("MainEditViewController ha sido liberado de memoria")
    }

    let themePresenter = ThemePresenter()

    private let label: UILabel = {
       
        let label = UILabel()
        label.text = "Texto Original"
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var editButton: UIButton = {
       
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Editar"
        configuration.titleAlignment = .center
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in self?.openEditor() } ))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
        
        applyTheme(themePresenter.getCurrentTheme())
        
        [label, editButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            editButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
    private func openEditor() {
        let secondVC = SecondEditViewController()
        secondVC.initialText = label.text
        secondVC.delegate = self
        present(secondVC, animated: true)
    }
    
    @objc func themeChanged(notification: Notification) {
        let theme = themePresenter.getCurrentTheme()
        applyTheme(theme)
    }
    
    func applyTheme(_ theme: ThemeType) {
        switch theme {
        case .light:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = .black
        }
    }
}

extension MainEditViewController: SecondViewControllerDelegate {
    
    func didUpdateText(text: String) {
        label.text = text
    }

}
