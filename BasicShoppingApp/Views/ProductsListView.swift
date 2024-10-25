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
    @ObservedObject var cartItems: AddToCard
    @State var searchText: String = ""
    
    var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return dao.products }
        return dao.products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    let numberOfRows = (filteredProducts.count + 1) / 2  // Filtrelenmiş ürün sayısına göre satır sayısını belirliyoruz

                    if numberOfRows > 0 {
                        ForEach(0..<numberOfRows, id: \.self) { row in
                            let startIndex = row * 2
                            let endIndex = min(startIndex + 1, filteredProducts.count - 1)
                            HStack {
                                    ForEach(startIndex...endIndex, id: \.self) { index in
                                        ProductCardView(product: filteredProducts[index], favoriteItems: favoriteItems, cartItems: cartItems)
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
    ProductsListView(favoriteItems: FavoritedProducts(), cartItems: AddToCard())
}

