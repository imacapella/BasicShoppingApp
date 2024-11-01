//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dao = ProductsDao()
    @StateObject var favoriteItems = FavoritedProducts()
    @StateObject var cart = Cart()
    
    var body: some View {
        TabView {
            ProductsListView(favoriteItems: favoriteItems,cartItems: cart ) // favoriteProducts'u buradan geçiriyoruz
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }

            FavoritesView(favoriteItems: favoriteItems) // Aynı favori listesini favoriler ekranına da geçiriyoruz
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }.onAppear{
                         dao.fetchData()
                }

            CartView(cart: cart)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }.task {
            if dao.products.isEmpty{
                 dao.fetchData()
            }
        }
    }
}




#Preview {
    ContentView()
    
}



