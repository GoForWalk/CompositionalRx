//
//  MainView.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import UIKit

import SnapKit

class MainView: BaseView {

    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        
        return collectionView
    }()
    
    override func configure() {
        super.configure()
        [collectionView, searchBar].forEach {
            addSubview($0)
        }
    }
    
    override func layoutConstraint() {
        super.layoutConstraint()
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
}
