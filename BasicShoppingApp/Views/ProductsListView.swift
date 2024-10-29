//
//  ProductsListView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 23.10.2024.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject var dao = ProductsDao()
    @ObservedObject var favoriteItems: FavoritedProducts
    @ObservedObject var cartItems: Cart
    @State var searchText: String = ""
    
    var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return dao.products }
        return dao.products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    let productsInPairs = Array(stride(from: 0, to: filteredProducts.count, by: 2))

                    if !filteredProducts.isEmpty {
                        ForEach(productsInPairs, id: \.self) { index in
                            HStack {
                                    ProductCardView(product: filteredProducts[index], favoriteItems: favoriteItems, cartItems: cartItems)
                                        .frame(maxWidth: .infinity)

                                if index + 1 < filteredProducts.count {
                                        ProductCardView(product: filteredProducts[index + 1], favoriteItems: favoriteItems, cartItems: cartItems)
                                            .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    } else {
                        ContentUnavailableView.search(text: searchText)
                    }
                }
                .navigationTitle("Products")
                .onAppear {
                    if dao.products.isEmpty && favoriteItems.favoriteProducts.isEmpty {
                        dao.fetchData()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search products...")
        }
    }
}


#Preview {
    ProductsListView(favoriteItems: FavoritedProducts(), cartItems: Cart())
}

