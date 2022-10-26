//
//  EndPoint.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/23.
//

import Foundation

enum EndPoint {
        
    case searchPhoto(query: String)
    case randomPhoto
    case listPhoto
    
}

extension EndPoint {

    var url: String {
        
        let baseURL = "https://api.unsplash.com"
        
        switch self {
        case .searchPhoto(let query):
            return "\(baseURL)/search/photos?query=\(query)"
        case .randomPhoto:
            return "\(baseURL)/photos/random"
        case .listPhoto:
            return "\(baseURL)/photos"
        }
    }

}
