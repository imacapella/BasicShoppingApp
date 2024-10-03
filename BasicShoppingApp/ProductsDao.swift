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
        guard let url = URL(string: endPoint) else {
            print("Invalid URL")
            return
        }

        // URLSession data task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Check if data is non-nil
            guard let data = data else {
                print("No data returned from server")
                return
            }

            do {
                // Decode JSON into Swift model
                let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                // Pass the products array to the completion handler
                completion(.success(productsResponse.products))
            } catch {
                // Handle JSON decoding errors
                completion(.failure(error))
            }
        }

        // Start the network request
        task.resume()
    }

}

