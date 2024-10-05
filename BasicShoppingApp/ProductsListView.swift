//
//  ProductsListView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 5.10.2024.
//

import SwiftUI

struct ProductsListView: View {
    
    @State private var products: [Product] = []
    @State private var isLoading = false
    var dao = ProductsDao()
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading products...")
            } else {
                List(products) { product in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .padding(.trailing)
                            } placeholder: {
                                // Placeholder while the image is being loaded
                                ProgressView()
                            }
                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.headline)
                                Text("Price: $\(product.price, specifier: "%.2f")")
                                Text("Rating: \(product.rating, specifier: "%.1f")")
                            }
                            Button(){
                                print("Move to details page...")
                            }label: {
                                VStack{
                                    Image(systemName: "chevron.forward.circle.fill")
                                    Text("Details")
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear {
            // Fetch data when the view appears
            dao.fetchData { result in
                print(isLoading)
                switch result {
                case .success(let products):
                    self.products = products
                    self.isLoading = false
                    print(isLoading)
                case .failure(let error):
                    print("Error fetching products: \(error)")
                    self.isLoading = false
                    print(isLoading)
                }
            }
        }
    }
}


#Preview {
    ProductsListView()
}
