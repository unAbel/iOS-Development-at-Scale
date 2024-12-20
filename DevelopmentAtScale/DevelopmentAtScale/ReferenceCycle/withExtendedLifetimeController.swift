//
//  withExtendedLifetimeController.swift
//  DevelopmentAtScale
//
//  Created by Abel on 20/12/24.
//

import Foundation
import UIKit

class withExtendedLifetimeController: UIViewController {
    
    
    
}


extension Engine2 {
    func typeMotor(){
        if let car = car {
            print("\(car.name) has \(self.type) motor")
            print("\(car.name) has \(car.engine!.type) motor")
        }
    }
}

// Ejemplo 1: withExtendedLifetime() alrededor de la llamada a printSummary()
func test1() {
    let car = Car2(name: "Ford")
    let engine = Engine2(type: "v8")
    engine.car = car
    car.engine = engine
    
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
        withExtendedLifetime(engine) {
            engine.typeMotor()
        }
    }
    
    withExtendedLifetime(engine) {
        engine.typeMotor()
    }
}

// Ejemplo 2: withExtendedLifetime() al final del scope
func test2() {
    let car = Car2(name: "Ford")
    let engine = Engine2(type: "v8")
    engine.car = car
    car.engine = engine
    
    engine.typeMotor()
    withExtendedLifetime(engine) {}

}

// Ejemplo 3: withExtendedLifetime() con defer
func test3() {
    let car = Car2(name: "Ford")
    let engine = Engine2(type: "v8")

    defer { withExtendedLifetime(engine) {} }
    engine.car = car
    car.engine = engine
    engine.typeMotor()
}
