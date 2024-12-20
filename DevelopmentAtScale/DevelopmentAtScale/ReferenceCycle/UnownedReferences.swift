//
//  UnownedReferences.swift
//  DevelopmentAtScale
//
//  Created by Abel on 19/12/24.
//

import Foundation
import UIKit

class UnownedReferences: UIViewController{
    private var car: Car3?
    private var engine: Engine3?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green.withAlphaComponent(0.6)
        
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
        car = Car3(name: "Herby")
        engine = Engine3(type: "V8", car: car!)
        
        car?.engine = engine // Strong reference
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


class Car3 {
    let name: String
    var engine: Engine3?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Car \(name) is being deinitialized")
    }
}

class Engine3 {
    let type: String
    unowned let car: Car3
    init(type: String, car: Car3) {
        self.type = type
        self.car = car
    }
    
    deinit {
        print("Engine \(type) is being deinitialized")
    }
}
