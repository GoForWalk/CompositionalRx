//
//  URLSessionEx.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/29.
//

import Foundation

protocol URLSessionService {
    func fetchImage(completionHandler: @escaping (Result<Data, NetworkError>) -> Void)

}

final class URLSessionServiceImpl: URLSessionService {
    
    let urlStr = "https://images-assets.nasa.gov/image/PIA15985/PIA15985~medium.jpg"
    
    func fetchImage(completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {

        guard let url = URLComponents(string: urlStr)?.url else {
            completionHandler(.failure(.urlError))
            return
        }
        
        print(url)
        
        do {
            
            let request = try URLRequest(url: url, method: .get)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error != nil {
                    completionHandler(.failure(.serverError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(.nonePhoto))
                    return
                }
                
                guard let data else {
                    completionHandler(.failure(.nonePhoto))
                    return
                }
                
                completionHandler(.success(data))
                
            }.resume()
            return
            
        } catch {
            completionHandler(.failure(.serverError))
            return
        }
    }
}
