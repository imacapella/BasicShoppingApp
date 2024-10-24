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
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    let numberOfRows = dao.products.count / 2

                    if numberOfRows > 0 {
                        ForEach(0..<numberOfRows, id: \.self) { row in
                            let startIndex = row * 2
                            let endIndex = min(startIndex + 1, dao.products.count - 1)
                            
                            HStack {
                                ForEach(startIndex...endIndex, id: \.self) { index in
                                    ProductCardView(product: $dao.products[index], favoriteItems: favoriteItems)
                                }
                            }
                        }
                    }

                    else{
                        ProgressView("Loading Products...")
                    }
                    
                }.navigationTitle("Products")
                .onAppear {
                    if dao.products.isEmpty && favoriteItems.favoriteProducts.isEmpty {
                        dao.fetchData()
                    }
                }
            }
        }
    }
}


#Preview {
    ProductsListView(favoriteItems: FavoritedProducts())
}
