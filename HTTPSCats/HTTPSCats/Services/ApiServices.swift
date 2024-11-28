//
//  ApiServices.swift
//  HTTPSCats
//
//  Created by Otávio Albuquerque on 01/07/24.
//

import Foundation

class ApiServices {
    
    static let singleton = ApiServices()
    private let baseURL = "https://http.cat/"
    
    
    func getCat(code: String) async -> Data? {
        let url = URL(string: baseURL)
        guard let url = url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.url?.append(path: code)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
            
        }catch {
            print(error)
        }
        
        return nil
    }
    
    func getCatCodeClosure(code: String, completion: @escaping (_ data: Data) -> Void){
        
        let url = URL(string: baseURL)
        guard let url = url else {return}
        var requestHeader = URLRequest(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.url?.append(path: code)
        
            URLSession.shared.dataTask(with: requestHeader) { data, _, _ in
                if let data = data {
                    completion(data)
                }
            }.resume()
    }
    
    func getCatCodeAlamofire(code: String, completion: @escaping (_ data: Data) -> Void){
        let url = baseURL.appending(code)
        
        AF.request(url, method: .get).response { response in
            completion(response.value!!)
        }
        
    }
    
    
    
}
