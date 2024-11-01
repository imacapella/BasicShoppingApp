//
//  ProductsDao.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 1.10.2024.
//

import Foundation

class ProductsDao: ObservableObject {
    @Published var products: [Product] = []
    
    // Fetch data function using URLSession
    func fetchData() {
        let endPoint = "https://dummyjson.com/products"
        
        guard let url = URL(string: endPoint) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Data fetch failed: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from URL")
                return
            }
            
            // Start the network request
            do {
                let productResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                
                // Update the products array on the main thread
                DispatchQueue.main.async {
                    self.products = productResponse.products
                }
                print("Data fetched successfully!")
                
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
