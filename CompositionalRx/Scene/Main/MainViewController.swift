//
//  MainViewController.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import UIKit

import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    // MARK: - Properties
    let mainView = MainView()

    let viewModel = MainViewModelImpl()
    let disposeBag = DisposeBag()
    
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
        configureDataSource()
//        mainView.searchBar.delegate = self
    }
    
    // MARK: - Binding
    override func setBinding() {
        
        viewModel.photoList
            .withUnretained(self)
            .subscribe { vc, photoList in
                var snapShot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapShot.appendSections([0])
                snapShot.appendItems(photoList.results)
                vc.dataSource.apply(snapShot)
            } onError: { error in
                print("==== error: \(error)")
            } onCompleted: {
                print("==== completed")
            } onDisposed: {
                print("onDispose")
            }
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { $0.viewModel.requestSearchPhoto(query: $1) }
            .disposed(by: disposeBag)
        
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
        
        // cellForItemAt && numberOfItemsInSection
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//extension MainViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    }
//
//}
