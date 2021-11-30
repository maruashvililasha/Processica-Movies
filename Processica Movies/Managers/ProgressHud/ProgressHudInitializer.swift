//
//  ProgressHudInitializer.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation
import ProgressHUD

class ProgressHUDManager : ManagerInitializer {
    
    func initialize() {
        ProgressHUD.animationType = .horizontalCirclesPulse
    }
}
