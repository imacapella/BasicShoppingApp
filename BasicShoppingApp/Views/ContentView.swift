//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dao = ProductsDao()
    @StateObject var favoriteProducts = FavoritedProducts()
    
    var body: some View {
        TabView {
            ProductsListView(favoriteItems: favoriteProducts) // favoriteProducts'u buradan geçiriyoruz
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }

            FavoritesView(favoriteItems: favoriteProducts) // Aynı favori listesini favoriler ekranına da geçiriyoruz
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            Text("Cart")
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
    }
}


// MARK: - TAB VIEW

// MARK: - TAB VIEW



#Preview {
    ContentView()
    
}




