//
//  MainViewModel.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import Foundation

import RxSwift
import RxRelay

final class MainViewModelImpl {
    
    private let apiService: APIService = APIServiceImpl()

    let photoList = PublishSubject<SearchPhoto>()
        
    func requestSearchPhoto(query: String) {
        
        apiService.fetchSearchPhoto(query: query) { [weak self] photoList, statusCode, error in
            
            guard let photoList else { return }
            self?.photoList.onNext(photoList)
            
        }
    }
    
}
