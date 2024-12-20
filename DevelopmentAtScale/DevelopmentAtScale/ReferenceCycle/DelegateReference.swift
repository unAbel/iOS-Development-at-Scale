//
//  DelegateReference.swift
//  DevelopmentAtScale
//
//  Created by Abel on 19/12/24.
//

import Foundation
import UIKit

class DelegateReference: UIViewController, ViewModelDelegate {
    let model = ViewModel() // ViewController mantiene una referencia fuerte a ViewModel.

    init() {
        super.init(nibName: nil, bundle: nil)
        model.delegate = self // ViewModel mantiene una referencia fuerte a ViewController.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func willLoadData() {
        // Realiza alguna tarea
    }
}

protocol ViewModelDelegate: AnyObject { // Se requiere AnyObject para usar `weak`
    func willLoadData()
}

class ViewModel {
    // Si esta propiedad no está etiquetada como `weak`, se generará un retain cycle.
    //var delegate: ViewModelDelegate?
    weak var delegate: ViewModelDelegate?

    func bootstrap() {
        delegate?.willLoadData()
    }
}


