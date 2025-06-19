//
//  TablePresenter.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import Foundation

protocol TableViewDelegate: AnyObject {
    func showUser(nombre: String)
    func withoutSession()
}

class TablePresenter {
    
    private let model = TableModel()
    let userService = UserService()
    weak var view: TableViewDelegate?
    
    init(view: TableViewDelegate? = nil) {
        self.view = view
    }
    
    func getCells() -> [ObjectCell] {
        return model.getCells()
    }
    
    func cellIn(index: Int) -> ObjectCell {
        
        return getCells()[index]
    }
    
    func viewDidLoad() {
        Logger.shared.log(message: "ViewController cargado")
        userService.login(usuario: "Carlos")
        Logger.shared.mostrarHistorial()
        SessionManager.shared.login(name: "Carlos")

        if SessionManager.shared.isLogged() {
            view?.showUser(nombre: SessionManager.shared.getUser() ?? "desconocido")
        } else {
            view?.withoutSession()
        }
    }

}
