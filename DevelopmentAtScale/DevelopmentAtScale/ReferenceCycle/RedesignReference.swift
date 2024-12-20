//
//  RedesignReference.swift
//  DevelopmentAtScale
//
//  Created by Abel on 20/12/24.
//

import Foundation
import UIKit

class RedesignReference: UIViewController{
    private var car: Car4?
    private var engine: Engine4?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green.withAlphaComponent(0.8)
        
        let labelCar = createLabel()
        let labelEngine = createLabel()
        view.addSubview(labelCar)
        view.addSubview(labelEngine)
        
        setupConstraints(for: labelCar, for: labelEngine)
        createObjectsWithCycle()
        testWeakReferences(labelCar: labelCar, labelEngine: labelEngine)
        print("check all reference count")
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
    private func setupConstraints(for label1: UILabel, for label2: UILabel) {
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label1.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            label2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label2.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 30)
        ])
    }
    
    // MARK: - Create Strong References
    private func createObjectsWithCycle() {
        let engineType = EngineType(type: "V8")
        car = Car4(name: "Herby", engineType: engineType)
        engine = Engine4(engineType: engineType)
    }
    
    // MARK: - Test Strong References
    private func testWeakReferences(labelCar: UILabel, labelEngine: UILabel) {
        print("Car reference count: \(CFGetRetainCount(car))")
        print("Engine reference count: \(CFGetRetainCount(engine))")
        // 1 reference (Internal System References)
        // 1 reference viewcontroller (Stack Frame)
        // 1 reference (Strong Reference)
        
        labelCar.text = "Car reference count: \(CFGetRetainCount(car))"
        labelEngine.text = "Engine reference count: \(CFGetRetainCount(engine))"
        
        car = nil
        engine = nil
    }
}

// se crea una clase adicional para romper el Ciclo de Referencia
class EngineType {
    var type: String

    init(type: String) {
        self.type = type
    }
}

class Car4 {
    var name: String
    var engineType: EngineType?

    init(name: String, engineType: EngineType? = nil) {
        self.name = name
        self.engineType = engineType
    }

    deinit {
        print("Car object is being deallocated")
    }

    func printEngineType() {
        if let engineType = engineType {
            print("Car \(name) has a \(engineType.type) engine")
        } else {
            print("Car \(name) has no engine")
        }
    }
}

class Engine4 {
    var engineType: EngineType
    
    init(engineType: EngineType) {
        self.engineType = engineType
    }

    deinit {
        print("Engine object is being deallocated")
    }
}
