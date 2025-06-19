//
//  SecondEditViewController.swift
//  PracticaBloque3
//
//  Created by Gopenux on 18/06/25.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func didUpdateText(text: String)
    
}

class SecondEditViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SecondEditViewController ha sido liberado de memoria")
    }
    
    weak var delegate: SecondViewControllerDelegate?
    var initialText: String?
    
    private let textField: UITextField = {
       
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ingresa un texto"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
       
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Guardar"
        configuration.titleAlignment = .center
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in self?.saveText() }))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        textField.text = initialText
        
        [textField, saveButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        SessionManager.shared.logout()
    }

    func saveText() {
        if let text = textField.text {
            delegate?.didUpdateText(text: text)
        }
        dismiss(animated: true)
    }
    
    @objc func handleSesionCerrada() {
        print("Sesión cerrada detectada")
    }
}
