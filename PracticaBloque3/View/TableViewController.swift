//
//  ViewController.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import UIKit

class TableViewController: UIViewController {
    
    
    var presenter: TablePresenter!
    let userService = UserService()
    let themePresenter = ThemePresenter()
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
        
    }()
    
    private lazy var buttonEditText: UIButton = {
        
        var configuratcion = UIButton.Configuration.plain()
        configuratcion.title = "Navegar a MainEditText"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.navegateMainEdit() }))
        button.configuration = configuratcion
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var buttonKVO: UIButton = {
        
        var configuratcion = UIButton.Configuration.plain()
        configuratcion.title = "Navegar a KVO"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.navegateKVO() }))
        button.configuration = configuratcion
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var buttonTheme: UIButton = {
        
        var configuratcion = UIButton.Configuration.plain()
        configuratcion.title = "Navegar a Theme"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.navegateTheme() }))
        button.configuration = configuratcion
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
        
        applyTheme(themePresenter.getCurrentTheme())
        
        presenter = TablePresenter(view: self)
        
        [tableView, buttonEditText, buttonKVO, buttonTheme].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonTheme.topAnchor, constant: -24),
            
            buttonTheme.bottomAnchor.constraint(equalTo: buttonKVO.topAnchor),
            buttonTheme.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonKVO.bottomAnchor.constraint(equalTo: buttonEditText.topAnchor),
            buttonKVO.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonEditText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonEditText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        presenter.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .logout, object: nil)
    }
    
    func navegateMainEdit() {
        self.navigationController?.pushViewController(MainEditViewController(), animated: true)
    }
    
    func navegateKVO() {
        self.navigationController?.pushViewController(KVOViewController(), animated: true)
    }
    
    func navegateTheme() {
        self.navigationController?.pushViewController(ThemeSwitcherViewController(), animated: true)
    }
    
    @objc func handleLogout() {
        print("Sesión cerrada detectada")
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

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCells().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let model = presenter.cellIn(index: indexPath.row)
        
        cell.configure(model: model)
        cell.delegate = self
        
        return cell
    }
    
}

extension TableViewController: Accions {
    func reproductiveButton(cell: TableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        print("reproduciendo en la celda \(indexPath.row+1)")
    }
    
}

extension TableViewController: TableViewDelegate {
    
    func showUser(nombre: String) {
        print("Usuario actual: \(nombre)")
    }
    
    func withoutSession() {
        print("No hay sesión activa")
    }
    
}
