//
//  BaseViewController.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setBinding()
    }
    
    func setBinding() {
        
    }
    
    func configure() {
        
    }
    
    deinit {
        print("❌❌❌❌❌❌ deinit: \(self.description) ❌❌❌❌❌❌")
    }
    
}
