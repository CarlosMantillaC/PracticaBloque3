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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        presenter = TablePresenter()
                
        [tableView, buttonEditText].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonEditText.topAnchor, constant: 24),
            
            buttonEditText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonEditText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])

        Logger.shared.log(message: "ViewController cargado")
        
        userService.login(usuario: "Carlos")
        
        Logger.shared.mostrarHistorial()
                
    }

    func navegateMainEdit() {
        self.navigationController?.pushViewController(MainEditViewController(), animated: true)
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
