//
//  MainViewModel.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import Foundation

final class MainViewModel {
    
    private let apiService: APIService = APIServiceImpl()

//    init
    
    struct Input {
        var query: String
    }
    
    struct Output {
        var photoList: CObservable<SearchPhoto?> = CObservable(nil)
    }
    
    
    func requestSearchPhoto(input: Input) {
        
        apiService.fetchSearchPhoto(query: input.query) { photoList, statusCode, error in
            
            let output = Output()
            
            guard let photoList else { return }
            output.photoList.value = photoList
            
        }
    }
    
}
