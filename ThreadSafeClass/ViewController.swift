//
//  ViewController.swift
//  ThreadSafeClass
//
//  Created by Alfian Losari on 03/09/17.
//  Copyright © 2017 Alfian Losari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let person = ThreadSafePerson(firstName: "Jon", lastName: "Weasley")
        let names = [("Cloud", "Strife"), ("Barret", "Wallace")]
        
        let nameChangeGroup = DispatchGroup()
        let workerQueue = DispatchQueue(label: "com.alfianlosari.concurrent", attributes: .concurrent)
        
        for (idx, name) in names.enumerated() {
            workerQueue.async(group: nameChangeGroup) {
                usleep(UInt32(10_000 * idx))
                person.change(firstName: name.0, lastName: name.1)
                print(person.name)
            }
            
        }
        
        nameChangeGroup.notify(queue: DispatchQueue.global(qos: .default)) {
            print("Final: \(person.name)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

