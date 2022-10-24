//
//  BaseView.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import UIKit

class BaseView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = ColorConstant.white
    }
    
    func layoutConstraint() {
        
    }
    
}

