//
//  SessionManager.swift
//  PracticaBloque3
//
//  Created by Gopenux on 18/06/25.
//

import Foundation


class SessionManager {
    
    static let shared = SessionManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let keyUsername = "username"
    
    func login(name: String) {
        
        userDefaults.set(name, forKey: keyUsername)
        print("[Session] Sesión iniciada para \(name)")
    }
    
    func logout() {
        userDefaults.removeObject(forKey: keyUsername)
        print("[Session] Sesión cerrada")
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    func isLogged() -> Bool {
        return userDefaults.string(forKey: keyUsername) != nil
    }
    
    func getUser() -> String? {
        return userDefaults.string(forKey: keyUsername)
    }
}

