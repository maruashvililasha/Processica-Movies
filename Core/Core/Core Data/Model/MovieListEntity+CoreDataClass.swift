//
//  MovieListEntity+CoreDataClass.swift
//  
//
//  Created by Lasha Maruashvili on 30.11.21.
//
//

import Foundation
import CoreData

@objc(MovieListEntity)
public class MovieListEntity: NSManagedObject {
    func isListValid() -> Bool {
        guard let listDate = self.date else {
            return false
        }
        let now = Date()
        guard let difference = Calendar.current.dateComponents([.second], from: listDate, to: now).second else {
            fatalError()
        }
        guard difference < 100 else {
            print("List \(self.page) outdated!")
            return false
        }
        return true
    }
}
