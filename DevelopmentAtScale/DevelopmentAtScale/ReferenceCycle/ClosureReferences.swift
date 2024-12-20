//
//  ClosureReferences.swift
//  DevelopmentAtScale
//
//  Created by Abel on 19/12/24.
//

import Foundation
import UIKit

class ClosureReferences:UIViewController {
    
    

    
}

class Person {
    let name: String
    init(name: String) { self.name = name }
    func eat() { print("\(name) está comiendo") }
    deinit { print("\(name) fue liberado") }
}

class ViewController {
    var person: Person
    var closure: (() -> Void)?

    init(person: Person) {
        self.person = person
    }

    func setupClosure() {
        closure = { [weak self, unowned person = self.person] in
            self?.doSomething()
            person.eat()
        }
    }

    func doSomething() {
        print("ViewController está haciendo algo")
    }   

    deinit {
        print("ViewController fue liberado")
    }
}


//DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
//    self?.myClosure?()
//}
