//
//  AppManagers.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

protocol ManagerInitializer {
    func initialize()
}

class AppManager {
    
    static let shared = AppManager()
    
    //     Add more initializers to array
    var managers : [ManagerInitializer] = [
        ProgressHUDManager()
    ]
    
    public func start() {
        managers.forEach({$0.initialize()})
    }
}
