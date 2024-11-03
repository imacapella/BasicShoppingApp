//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dao: ProductsDao
    @ObservedObject var favoriteItems: FavoritedProducts
    @ObservedObject var cartViewModel: CartViewModel  // cartViewModel parametresi

    var body: some View {
        TabView {
            ProductsListView(favoriteItems: favoriteItems, cartItems: cartViewModel.cart)
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }

            FavoritesView(favoriteItems: favoriteItems)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            CartView(viewModel: cartViewModel, cart: cartViewModel.cart)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
        .task {
            if dao.products.isEmpty {
                dao.fetchData()
            }
        }
    }
}




