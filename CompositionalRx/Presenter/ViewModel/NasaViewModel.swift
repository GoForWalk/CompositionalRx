//
//  NasaViewModel.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/29.
//

import Foundation

import RxSwift
import RxRelay

protocol NasaViewModel {
    var imageData: PublishSubject<Data> { get }
    
    func fetchImage()
}

struct NasaViewModelImpl: NasaViewModel {
    
    private let urlSessionService: URLSessionService = URLSessionServiceImpl()
    
    // OutData
    let imageData = PublishSubject<Data>()
    
    func fetchImage() {
        urlSessionService.fetchImage { result in
            switch result {
            case .success(let data):
                imageData.onNext(data)
                
            case .failure(let error):
                print("Error: \(error)")
                return
            }
        }
    }
    
}
