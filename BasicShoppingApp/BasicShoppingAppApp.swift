//
//  BasicShoppingAppApp.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

@main
struct BasicShoppingAppApp: App {
    @StateObject private var cart = Cart()
    @StateObject private var favoriteItems = FavoritedProducts()
    @StateObject private var dao = ProductsDao()

    var body: some Scene {
        WindowGroup {
            ContentView(
                dao: dao,
                favoriteItems: favoriteItems,
                cartViewModel: CartViewModel(cart: cart)  // CartViewModel örneğini burada oluşturuyoruz
            )
        }
    }
}
