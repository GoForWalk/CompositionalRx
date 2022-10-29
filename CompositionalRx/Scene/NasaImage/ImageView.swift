//
//  ImageView.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/29.
//

import UIKit

import SnapKit

final class NasaView: BaseView {
    
    let mainImageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    override func configure() {
        super.configure()
        
        self.addSubview(mainImageView)
    }
    
    override func layoutConstraint() {
        super.layoutConstraint()
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

