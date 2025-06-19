//
//  TableModel.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import Foundation

class TableModel {
    
    private var cells: [ObjectCell] = [
        
        ObjectCell(title: "1"),
        ObjectCell(title: "2"),
        ObjectCell(title: "3"),
        ObjectCell(title: "4"),
        ObjectCell(title: "5"),
        ObjectCell(title: "6"),

    
    ]
    
    func getCells() -> [ObjectCell] {
        return cells
    }
    
    
    
}
