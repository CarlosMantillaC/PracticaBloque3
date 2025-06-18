//
//  TablePresenter.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import Foundation

class TablePresenter {
    
    private let model = TableModel()
    
    func getCells() -> [ObjectCell] {
        return model.getCells()
    }
    
    func cellIn(index: Int) -> ObjectCell {
        
        return getCells()[index]
    }

    
}
