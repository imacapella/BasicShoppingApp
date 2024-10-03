//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    @State private var isLoading = true
    var dao = ProductsDao()

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading products...")
            } else {
                List(products) { product in
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.headline)
                        Text("Price: $\(product.price, specifier: "%.2f")")
                        Text("Rating: \(product.rating)")
                    }
                }
            }
        }
        .onAppear {
            // Fetch data when the view appears
            dao.fetchData { result in
                switch result {
                case .success(let products):
                    self.products = products
                    self.isLoading = false
                case .failure(let error):
                    print("Error fetching products: \(error)")
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
