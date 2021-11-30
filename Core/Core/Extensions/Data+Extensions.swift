//
//  Data+Extensions.swift
//  Core
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import Foundation

extension Data {
    func prettyPrint() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
}
