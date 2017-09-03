//
//  Person.swift
//  ThreadSafeClass
//
//  Created by Alfian Losari on 03/09/17.
//  Copyright © 2017 Alfian Losari. All rights reserved.
//

import Foundation

class ThreadSafePerson {
    
    var firstName: String
    var lastName: String
    
    let isolationQueue = DispatchQueue(label: "com.alfianlosari.isolation", attributes: .concurrent)
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func change(firstName: String, lastName: String) {
        isolationQueue.async(flags: .barrier) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    var name: String {
        return isolationQueue.sync {
            return "\(firstName) \(lastName)"
        }
    }
    
}
