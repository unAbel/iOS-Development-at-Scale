//
//  StrongReferences.swift
//  DevelopmentAtScale
//
//  Created by Abel on 19/12/24.
//

import Foundation
import UIKit

class StrongReferences: UIViewController{
    private var car: Car?
    private var engine: Engine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red.withAlphaComponent(0.4)
        
        let labelCar = createLabel()
        let labelEngine = createLabel()
        view.addSubview(labelCar)
        view.addSubview(labelEngine)
        
        setupConstraints(for: labelCar, for: labelEngine)
        createStrongReferences()
        testStrongReferences(labeCar: labelCar, labelEngine: labelEngine)
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
    private func createStrongReferences() {
        car = Car(name: "Herby")
        engine = Engine(type: "V8")
        
        car?.engine = engine // Strong reference
        engine?.car = car    // Strong reference, causing a cycle
    }
    
    // MARK: - Test Strong References
    private func testStrongReferences(labeCar: UILabel, labelEngine: UILabel) {
        print("Car reference count: \(CFGetRetainCount(car))")
        print("Engine reference count: \(CFGetRetainCount(engine))")
        // 1 reference (Internal System References)
        // 1 reference viewcontroller (Stack Frame)
        // 1 reference (Strong Reference)
        
        labeCar.text = "Car reference count: \(CFGetRetainCount(engine))"
        labelEngine.text = "Engine reference count: \(CFGetRetainCount(engine))"
        
        car = nil // Memory not released due to strong reference cycle
        engine = nil // Memory not released due to strong reference cycle
    }
}


// MARK: - Engine Class
class Engine {
    let type: String
    var car: Car? // Strong reference creates the cycle
    
    init(type: String) {
        self.type = type
    }
    
    deinit {
        print("Engine \(type) is being deinitialized")
    }
}

// MARK: - Car Class
class Car {
    let name: String
    var engine: Engine? // Strong reference creates the cycle
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Car \(name) is being deinitialized")
    }
}
