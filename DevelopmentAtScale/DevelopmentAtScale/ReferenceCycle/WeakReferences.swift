//
//  WeakReferences.swift
//  DevelopmentAtScale
//
//  Created by Abel on 19/12/24.
//

import Foundation
import UIKit

class WeakReferences: UIViewController{
    private var car: Car2?
    private var engine: Engine2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow.withAlphaComponent(0.4)
        
        let labelCar = createLabel()
        let labelEngine = createLabel()
        view.addSubview(labelCar)
        view.addSubview(labelEngine)
        
        setupConstraints(for: labelCar, for: labelEngine)
        createObjectsWithCycle()
        testWeakReferences(labelCar: labelCar, labelEngine: labelEngine)
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
        car = Car2(name: "Herby")
        engine = Engine2(type: "V8")
        
        car?.engine = engine // Strong reference
        engine?.car = car    // Strong reference, causing a cycle
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

// MARK: - Vehicle Class
class Car2 {
    let name: String
    var engine: Engine2?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Vehicle \(name) is being deinitialized")
    }
}

// MARK: - Motor Class
class Engine2 {
    let type: String
    weak var car: Car2? // Weak reference prevents strong reference cycle
    
    init(type: String) {
        self.type = type
    }
    
    deinit {
        print("Motor \(type) is being deinitialized")
    }
}
