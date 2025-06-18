//
//  Logger.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import Foundation

final class Logger {
    
    static let shared = Logger()
    private var historic: [String] = []
    
    private init() {}
    
    func log(message: String) {
        
        let finalMessage = "[LOG] \(message)"
        historic.append(finalMessage)
        print(finalMessage)
        
    }
    
    func mostrarHistorial() {
        
        for message in historic {
            print(message)
        }
    }
    
}


