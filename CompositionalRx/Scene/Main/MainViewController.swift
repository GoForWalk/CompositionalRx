//
//  MainViewController.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import UIKit

final class MainViewController: BaseViewController, ImageCache {
    
    // MARK: - Properties
    let mainView = MainView()
    
    var input = InputMainViewData()
    var output = OutputMainViewData()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    // MARK: - ViewLifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func configure() {
        
        mainView.collectionView.delegate = self
        mainView.collectionView.collectionViewLayout = createLayout()
        mainView.searchBar.delegate = self
    }
    
    // MARK: - Binding
    override func setBinding() {
        
    }
    

}

// MARK: - Diffable Setting
extension MainViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            // TODO: imageCache
            DispatchQueue.global(qos: .default).async {
                guard let url = URL(string: itemIdentifier.urls.thumb) else { return }
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            // cell background
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .blue
            cell.backgroundConfiguration = background
            
        }
        
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
