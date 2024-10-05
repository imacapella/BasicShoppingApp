//
//  ProductsDao.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 1.10.2024.
//

import Foundation

class ProductsDao {
    // Fetch data function using URLSession
    func fetchData(completion: @escaping (Result<[Product], Error>) -> Void) {
        let endPoint = "https://dummyjson.com/products"
        
        guard let url = URL(string: endPoint) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                print("olmadı be abi")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data returned from URL")
                return
            }
            // Start the network request
            
            do{
                let productResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                // Pass the products array to the completion handler
                completion(.success(productResponse.products))
                print("oldu abi")
                
            }catch{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
