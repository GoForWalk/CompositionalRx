//
//  APIService.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/24.
//

import Foundation

import Alamofire

protocol APIService {
    
    func fetchSearchPhoto(query: String, completionHandler: @escaping (SearchPhoto?, Int?, Error?) -> Void)
//    func fetchSearchPhoto(query: String, completionHandler: @escaping (Result<SearchPhoto, NetworkError>) -> Void)
    
}

class APIServiceImpl: APIService {
    
    func fetchSearchPhoto(query: String, completionHandler: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
//    func fetchSearchPhoto(query: String, completionHandler: @escaping (Result<SearchPhoto, NetworkError>) -> Void) {
        
        guard let url = URL(string: EndPoint.searchPhoto(query: query).url) else { return }
        
        let header: HTTPHeaders = ["Authorization": APIKeys.unsplashClientId]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            
            let statusCode = response.response?.statusCode // 상태코드
            
            switch response.result {
            case .success(let value): print(value); completionHandler(value, statusCode, nil)
            case .failure(let error): print(error); completionHandler(nil, statusCode, error)
            }
            
        }
        
    }
        
}
